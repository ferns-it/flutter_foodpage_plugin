import 'dart:developer';

import 'package:example/order_online/view/order/online_order_page.dart';
import 'package:example/order_online/view/shop/shop_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controller/dashboard/dashboard_controller.dart';
import '../login/login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with ReservationSocketHandler {
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
      authenticationKey: "5521bacd985f98bbcb30c9e0f1a242ae",
      shopId: '1',
      socketHandler: this,
      onFcmTopicRegister: (topic) {},
    );
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

  Future<void> newReservation() async {
    final payload = {
      "userID": 0,
      "name": "Sankar",
      "phone": "9895198951",
      "email": "test@test.com",
      "chairs": "2",
      "message": "message",
      "shopmessage": "message from shop - optional",
      "bookingTime": "2024-02-20 10:10:10",
      "advancePayment": "Yes",
      "advanceAmount": "100",
      "amountStatus": "Ready",
      "paymentMethod": "STRIPE",
      "transactionID": "123",
      "source": "Flutter"
    };
    final reservation = NewReservationModel.fromMap(payload);
    await foodpageTableReservation.newReservation(reservation);
  }

  @override
  void onJoinedRoom(String roomId) {
    log(roomId);
  }

  @override
  void onNewCustomerChatReceived(ChatMessage message, notification) {
    log("onNewCustomerChatReceived");
    inspect(message);
  }

  @override
  void onNewReservationReceived(EnquirieModel reservation) {
    inspect(reservation);
  }

  @override
  void onNewShopChatReceived(ChatMessage message) {
    log("onNewShopChatReceived");
    inspect(message);
  }

  @override
  void onNewApprovedReservationRecieved(EnquirieModel reservation) {
    inspect(reservation);
  }

  @override
  void onSocketConnected() {
    // TODO: implement onSocketConnected
  }

  @override
  void onSocketDisconnected() {
    // TODO: implement onSocketDisconnected
  }

  @override
  void onSocketError(error) {
    // TODO: implement onSocketError
  }

  @override
  void onNotificationStatusUpdated(ReservationNotificationModel enquire) {
    inspect(enquire);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Table Reservation"),
      ),
      body: Column(
        children: [
          Expanded(
            child: newRequestCollection.when(
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
                      title: Text("${enquiry.name} (${enquiry.id})"),
                      subtitle: Text(enquiry.amountStatus.toString()),
                      leading: const Icon(Icons.table_restaurant),
                      onTap: () async {
                        final response = await foodpageTableReservation
                            .revokeAdvance(enquiry.id ?? "");
                        inspect(response);
                      },
                    );
                  },
                );
              },
              error: (message, exceptions) {
                return Text(message ?? "Something went wrong");
              },
            ),
          ),
          const SizedBox(height: 100),
          ElevatedButton(
              onPressed: () {
                newReservation();
              },
              child: const Text("New Booking"))
        ],
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
