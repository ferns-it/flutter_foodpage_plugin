import 'package:flutter_foodpage_plugin/table_reservation/base_client.dart';
import 'package:flutter_foodpage_plugin/table_reservation/constants/api_endpoints.dart';

import '../models/new_request/new_request_collection.dart';

class TableReservationService {
  static Future<NewRequestsCollection?> getNewRequests() async {
    final result = await BaseClient.get(api: ApiEndpoints.getNewRequests);
    if (result == null) return null;
    return NewRequestsCollection.fromJson(result);
  }

  static Future<NewRequestsCollection?> getUpcomingList() async {
    final result = await BaseClient.get(api: ApiEndpoints.getUpcomingRequests);
    if (result == null) return null;
    return NewRequestsCollection.fromJson(result);
  }
}
