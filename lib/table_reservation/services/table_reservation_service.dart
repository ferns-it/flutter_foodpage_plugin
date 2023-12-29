import 'dart:convert';

import 'base_client.dart';
import '../constants/api_endpoints.dart';

import '../constants/enums.dart';
import '../models/new_request/new_request_collection_model.dart';
import '../models/reservation/reservation_details_model.dart';
import '../models/reservation/update_reservation_request_model.dart';
import '../models/upcoming_request/upcoming_request_collection_model.dart';
import 'reservation_service_abstract.dart';

class TableReservationService implements ReservationService {
  @override
  Future<NewRequestCollectionModel?> getNewRequests() async {
    final result = await BaseClient.get(api: ApiEndpoints.getNewRequests);
    if (result == null) return null;
    return NewRequestCollectionModel.fromJson(result);
  }

  @override
  Future<UpcomingRequestCollection?> getUpcomingList() async {
    final result = await BaseClient.get(api: ApiEndpoints.getUpcomingRequests);
    if (result == null) return null;
    return UpcomingRequestCollection.fromJson(result);
  }

  @override
  Future<ReservationDetailsModel?> getReservationDetails(
      String reservationID) async {
    final details = await BaseClient.post(
      api: ApiEndpoints.getdata,
      data: json.encode({"reservationID": reservationID}),
    );
    if (details == null) return null;
    return ReservationDetailsModel.fromJson(details);
  }

  @override
  Future<ResponseResult?> updateReservationDetails(
    UpdateReservationRequestModel payload,
  ) async {
    final details = await BaseClient.put(
      api: ApiEndpoints.getdata,
      data: payload.toJson(),
      additionalHeaders: {"reservationId": payload.reservationId},
    );
    if (details == null) return ResponseResult.failure;
    return ResponseResult.success;
  }
}
