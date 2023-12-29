import '../constants/enums.dart';
import '../models/new_request/new_request_collection_model.dart';
import '../models/reservation/reservation_details_model.dart';
import '../models/reservation/update_reservation_request_model.dart';
import '../models/upcoming_request/upcoming_request_collection_model.dart';

abstract class ReservationService {
  Future<NewRequestCollectionModel?> getNewRequests();

  Future<UpcomingRequestCollection?> getUpcomingList();

  Future<ReservationDetailsModel?> getReservationDetails(String reservationID);

  Future<ResponseResult?> updateReservationDetails(
    UpdateReservationRequestModel payload,
  );
}
