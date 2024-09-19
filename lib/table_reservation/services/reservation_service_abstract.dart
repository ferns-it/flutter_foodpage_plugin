import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/table_reservation_service.dart';

import '../models/history/history_request_collection_model.dart';
import '../models/send_message/send_message_model.dart';

abstract class ReservationService {
  static final ReservationService _instance = TableReservationService();

  static ReservationService get instance => _instance;


  Future<EnquirieModel?> newReservation(NewReservationModel reservation);

  Future<NewRequestCollectionModel?> getNewRequests({String? searchQuery});

  Future<UpcomingRequestCollection?> getUpcomingList({String? searchQuery});

  Future<ReservationDetailsModel?> getReservationDetails(String reservationID);

  Future<ReservationHistoryRequestCollectionModel?> getReservationHistory(
      {String? searchQuery});

  Future<ResponseResult> approveOrCancelReservation(
    ApproveOrCancelRequestModel payload,
  );

  Future<ChatMessage?> sendMessageToCustomer(SendMessageModel message);

  Future<EnquirieModel?> collectAdvancePayment(String reservationId);

  Future<EnquirieModel?> revokeAdvancePayment(String reservationId);

  Future<EnquirieModel?> refundAdvancePayment(String reservationId);
}
