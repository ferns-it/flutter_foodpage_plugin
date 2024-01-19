import 'dart:convert';

import 'package:flutter_foodpage_plugin/table_reservation/models/enquire/enquire_model.dart';
import 'package:flutter_foodpage_plugin/table_reservation/models/send_message/send_message_model.dart';

import '../constants/api_endpoints.dart';
import '../constants/enums.dart';
import '../models/history/history_request_collection_model.dart';
import '../models/new_request/new_request_collection_model.dart';
import '../models/reservation/reservation_details_model.dart';
import '../models/reservation/approve_or_cancel_request_model.dart';
import '../models/upcoming_request/upcoming_request_collection_model.dart';
import 'base_client.dart';
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
  Future<ResponseResult> approveOrCancelReservation(
    ApproveOrCancelRequestModel payload,
  ) async {
    final details = await BaseClient.put(
      api: ApiEndpoints.updateRequest,
      data: payload.toJson(),
      params: payload.reservationId,
    );
    if (details == null) return ResponseResult.failure;
    return ResponseResult.success;
  }

  @override
  Future<ReservationHistoryRequestCollectionModel?>
      getReservationHistory() async {
    final data = await BaseClient.get(api: ApiEndpoints.gethistory);
    if (data == null) return null;
    return ReservationHistoryRequestCollectionModel.fromJson(data);
  }

  @override
  Future<ChatMessage?> sendMessageToCustomer(SendMessageModel message) async {
    final response = await BaseClient.post(
      api: ApiEndpoints.sendCustomerMessage,
      data: message.toJson(),
    );
    if (response == null) return null;
    final decodedJson = json.decode(response);
    final messageData = decodedJson['messageData'];
    return ChatMessage.fromMap(messageData);
  }

  @override
  Future<EnquirieModel?> collectAdvancePayment(String reservationId) async {
    final response = await BaseClient.post(
      api: ApiEndpoints.captureamount,
      params: reservationId,
    );
    if (response == null) return null;
    final enquiryData = jsonDecode(response)['enquiryData'];
    return EnquirieModel.fromMap(enquiryData);
  }

  @override
  Future<EnquirieModel?> refundAdvancePayment(String reservationId) async {
    final response = await BaseClient.post(
      api: ApiEndpoints.refundAmount,
      params: reservationId,
    );
    if (response == null) return null;
    final enquiryData = jsonDecode(response)['enquiryData'];
    return EnquirieModel.fromMap(enquiryData);
  }

  @override
  Future<EnquirieModel?> revokeAdvancePayment(String reservationId) async {
    final response = await BaseClient.post(
      api: ApiEndpoints.cancelcapturedamount,
      params: reservationId,
    );
    if (response == null) return null;
    final enquiryData = jsonDecode(response)['enquiryData'];
    return EnquirieModel.fromMap(enquiryData);
  }
}
