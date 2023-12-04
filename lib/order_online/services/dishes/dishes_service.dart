import 'dart:convert';

import '../../constants/api_endpoints.dart';
import '../../model/dishes/dishes_data.dart';
import '../base_client.dart';

class DishesService {
    static Future<List<DishData>> fetchAllDishes() async {
    final response =
        await BaseClient.get(api: ApiEndpoints.listAllDishes, needAuth: true);
    if (response == null) return <DishData>[];
    final decodedJson = jsonDecode(response) as List;
    final dishList = decodedJson.map((item) {
      return DishData.fromMap(item as Map<String, dynamic>);
    }).toList();
    return dishList;
  }
  
}