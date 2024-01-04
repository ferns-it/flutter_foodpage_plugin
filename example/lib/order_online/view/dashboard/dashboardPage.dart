import 'package:example/order_online/view/order/online_order_page.dart';
import 'package:example/order_online/view/shop/shop_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:flutter_foodpage_plugin/table_reservation/models/common/api_response.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controller/dashboard/dashboard_controller.dart';
import '../login/login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late FoodpageTableReservation foodpageTableReservation;

  APIResponse<NewRequestCollectionModel> newRequestCollection =
      APIResponse<NewRequestCollectionModel>.initial();

  @override
  void initState() {
    createInstance();
    super.initState();
  }

  Future<void> createInstance() async {
    foodpageTableReservation = await FoodpageTableReservation.create(
        authenticationKey: "5521bacd985f98bbcb30c9e0f1a242ae");
    getNewRequests();
  }

  Future<void> getNewRequests() async {
    setState(() {
      newRequestCollection = APIResponse.loading();
    });
    final response = await foodpageTableReservation.getNewRequests();
    setState(() {
      newRequestCollection = response;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Table Reservation"),
      ),
      body: newRequestCollection.when(
        initial: () {
          return const SizedBox();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        completed: (data) {
          return ListView.builder(
              itemCount: data.enquiries.length,
              itemBuilder: (context, index) {
                final enquiry = data.enquiries[index];
                return ListTile(
                  title: Text(enquiry.name.toString()),
                  subtitle: Text(enquiry.id.toString()),
                  leading: const Icon(Icons.table_restaurant),
                );
              });
        },
        error: (message, exceptions) {
          return Text(message ?? "Something went wrong");
        },
      ),
    );
  }
}

class _DashboardCard extends GetView<DashboardController> {
  const _DashboardCard({
    Key? key,
    required this.itemName,
    required this.itemIndex,
    required this.label,
  }) : super(key: key);
  final String itemName, label;
  final int itemIndex;
  @override
  Widget build(BuildContext context) {
    final navigationList = [
      const LoginPage(),
      const OnlineOrderPage(),
      const ShopStatusPage(),
    ];

    return SizedBox(
      height: 100.0,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          controller.onSelectedIndexChange(itemIndex);
          if (controller.selectedIndex == itemIndex) {
            Get.to(() => navigationList[itemIndex]);
          }
        },
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  itemName.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ) // green shaped
                      ),
                  child: Text(
                    label.toUpperCase(),
                    style: const TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
