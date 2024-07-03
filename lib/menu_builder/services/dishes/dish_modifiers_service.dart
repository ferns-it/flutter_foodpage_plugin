import 'dart:convert';
import 'dart:developer';

import 'package:flutter_foodpage_plugin/menu_builder/models/modifiers/dish_modifiers_collection.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';

import '../../core/constants/api_endpoints.dart';
import '../../core/constants/enums.dart';
import '../../models/modifiers/add_dish_modifiers_model.dart';

class DishModifiersService {
  static Future<DishModifiersCollection?> getModifiersList() async {
    final addonsGroupJsonList = await BaseClient.get(
      api: ApiEndpoints.modifiersList,
      dataKey: "addonsGrops",
      dataKeyChecking: true,
      needAuth: true,
    );

    if (addonsGroupJsonList == null) return null;
    final modifiersList = (jsonDecode(addonsGroupJsonList) as List).map((e) {
      return DishModifierData.fromMap(e);
    }).toList();
    return DishModifiersCollection(masterModifiers: modifiersList);
  }

  static Future<APIResultType> addModifier(
      AddDishModifiersModel payload) async {
    try {
      final response = await BaseClient.post(
        api: ApiEndpoints.addModifier,
        data: payload.toJson(),
      );
      if (response == null) return APIResultType.failed;
      return APIResultType.success;
    } on Exception catch (e) {
      log(e.toString(), name: "addModifier");
      return APIResultType.failed;
    }
  }

  static Future<APIResultType> updateModifiers(
      String groupId, AddDishModifiersModel payload) async {
    try {
      final response = await BaseClient.put(
        api: "${ApiEndpoints.updateModifier}/$groupId",
        data: payload.toJson(),
        needAuth: true,
      );
      if (response == null) return APIResultType.failed;
      return APIResultType.success;
    } on Exception catch (e) {
      log(e.toString(), name: "updateModifiers");
      return APIResultType.failed;
    }
  }

  static Future<APIResultType> disableEnableModifiers(
    String groupId,
    bool status,
  ) async {
    try {
      final response = await BaseClient.put(
        api: "${ApiEndpoints.statusUpdate}/$groupId",
        data: status
            ? jsonEncode({"status": "Active"})
            : jsonEncode({"status": "Inactive"}),
      );
      if (response == null) return APIResultType.failed;
      return APIResultType.success;
    } on Exception catch (e) {
      log(e.toString(), name: "disableEnableModifiers");
      return APIResultType.failed;
    }
  }
}
