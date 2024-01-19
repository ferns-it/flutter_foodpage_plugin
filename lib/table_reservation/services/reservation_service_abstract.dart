import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/table_reservation_service.dart';

import '../constants/enums.dart';
import '../models/history/history_request_collection_model.dart';
import '../models/new_request/new_request_collection_model.dart';
import '../models/reservation/reservation_details_model.dart';
import '../models/reservation/approve_or_cancel_request_model.dart';
import '../models/send_message/send_message_model.dart';
import '../models/upcoming_request/upcoming_request_collection_model.dart';

abstract class ReservationService {
  static final ReservationService _instance = TableReservationService();
  static ReservationService get instance => _instance;
  Future<NewRequestCollectionModel?> getNewRequests();
  Future<UpcomingRequestCollection?> getUpcomingList();
  Future<ReservationDetailsModel?> getReservationDetails(String reservationID);
  Future<ReservationHistoryRequestCollectionModel?> getReservationHistory();
  Future<ResponseResult> approveOrCancelReservation(
    ApproveOrCancelRequestModel payload,
  );
  Future<ChatMessage?> sendMessageToCustomer(SendMessageModel message);
  Future<EnquirieModel?> collectAdvancePayment(String reservationId);
  Future<EnquirieModel?> revokeAdvancePayment(String reservationId);
  Future<EnquirieModel?> refundAdvancePayment(String reservationId);
}
