// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:flutter_foodpage_plugin/table_reservation/constants/enums.dart';
import 'package:flutter_foodpage_plugin/table_reservation/models/common/api_response.dart';
import 'package:flutter_foodpage_plugin/table_reservation/models/send_message/send_message_model.dart';
import 'package:flutter_foodpage_plugin/table_reservation/models/upcoming_request/upcoming_request_collection_model.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/app_exception/app_exception.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/reservation_service_abstract.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/shared_preference/auth_preference.dart';

import 'models/history/history_request_collection_model.dart';
import 'models/new_request/new_request_collection_model.dart';
import 'models/reservation/reservation_details_model.dart';
import 'models/reservation/update_reservation_request_model.dart';

class FoodpageTableReservation {
  static final _preference = AuthPreference();

  FoodpageTableReservation._internal();

  static Future<FoodpageTableReservation> create({
    required String authenticationKey,
  }) async {
    // Call the private constructor
    final instance = FoodpageTableReservation._internal();
    // Do initialization that requires async
    await _preference.saveAuthKeyData(authenticationKey);
    // Return the fully initialized object
    return instance;
  }

  APIResponse<T> _throwNotFoundException<T>() {
    return APIResponse.error(
      "The requested api data was not found.",
      exception: NotFoundException(),
    );
  }

  APIResponse<T> _throwInvalidResponseFromServer<T>() {
    return APIResponse.error(
      "Invalid response from the server.",
      exception: InternalServerErrorException(),
    );
  }

  APIResponse<T> _throwUnknownErrorException<T>() {
    final error = UnknwonErrorException();
    return APIResponse.error(
      error.prefix,
      exception: error,
    );
  }

  Future<APIResponse<NewRequestCollectionModel>> getNewRequests() async {
    // try {
    final response = await ReservationService.instance.getNewRequests();
    if (response == null) {
      return _throwNotFoundException<NewRequestCollectionModel>();
    }
    return APIResponse.completed(response);
    // } on AppExceptions catch (error) {
    //   return APIResponse.error(error.message, exception: error);
    // } catch (e) {
    //   return _throwUnknownErrorException<NewRequestCollectionModel>();
    // }
  }

  Future<APIResponse<UpcomingRequestCollection>> getUpcomingRequests() async {
    try {
      final response = await ReservationService.instance.getUpcomingList();
      if (response == null) {
        return _throwNotFoundException<UpcomingRequestCollection>();
      }
      return APIResponse.completed(response);
    } on AppExceptions catch (error) {
      return APIResponse.error(error.message, exception: error);
    } catch (e) {
      return _throwUnknownErrorException<UpcomingRequestCollection>();
    }
  }

  Future<APIResponse<ReservationHistoryRequestCollectionModel>>
      getReservationHistory() async {
    try {
      final response =
          await ReservationService.instance.getReservationHistory();
      if (response == null) {
        return _throwNotFoundException<
            ReservationHistoryRequestCollectionModel>();
      }
      return APIResponse.completed(response);
    } on AppExceptions catch (error) {
      return APIResponse.error(error.message, exception: error);
    } catch (e) {
      return _throwUnknownErrorException<
          ReservationHistoryRequestCollectionModel>();
    }
  }

  Future<APIResponse<ReservationDetailsModel>> getReservationDetails(
      String reservationID) async {
    try {
      final response = await ReservationService.instance.getReservationDetails(
        reservationID,
      );
      if (response == null) _throwNotFoundException<ReservationDetailsModel>();
      return APIResponse.completed(response);
    } on AppExceptions catch (error) {
      return APIResponse.error(error.message, exception: error);
    } catch (e) {
      return _throwUnknownErrorException<ReservationDetailsModel>();
    }
  }

  Future<ResponseResult> updateReservationDetails(
    UpdateReservationRequestModel payload,
  ) async {
    try {
      final response =
          await ReservationService.instance.updateReservationDetails(
        payload,
      );
      return response;
    } catch (e) {
      return ResponseResult.failure;
    }
  }

  Future<APIResponse<ChatMessage>> sendMessageToCustomer(
      SendMessageModel message) async {
    final response = await ReservationService.instance.sendMessageToCustomer(
      message,
    );
    if (response == null) _throwInvalidResponseFromServer<ChatMessage>();
    return APIResponse.completed(response);
  }

  Future<APIResponse<EnquirieModel>> collectAdvance(
    String reservationID,
  ) async {
    try {
      final response = await ReservationService.instance
          .collectAdvancePayment(reservationID);
      if (response == null) _throwInvalidResponseFromServer<EnquirieModel>();
      return APIResponse.completed(response);
    } on AppExceptions catch (error) {
      return APIResponse.error(error.message, exception: error);
    } catch (e) {
      return _throwUnknownErrorException<EnquirieModel>();
    }
  }

  Future<APIResponse<EnquirieModel>> revokeAdvance(
    String reservationID,
  ) async {
    try {
      final response = await ReservationService.instance.revokeAdvancePayment(
        reservationID,
      );
      if (response == null) _throwInvalidResponseFromServer<EnquirieModel>();
      return APIResponse.completed(response);
    } on AppExceptions catch (error) {
      return APIResponse.error(error.message, exception: error);
    } catch (e) {
      return _throwUnknownErrorException<EnquirieModel>();
    }
  }

  Future<APIResponse<EnquirieModel>> refundAdvancePayment(
    String reservationID,
  ) async {
    try {
      final response = await ReservationService.instance.refundAdvancePayment(
        reservationID,
      );
      if (response == null) _throwInvalidResponseFromServer<EnquirieModel>();
      return APIResponse.completed(response);
    } on AppExceptions catch (error) {
      return APIResponse.error(error.message, exception: error);
    } catch (e) {
      return _throwUnknownErrorException<EnquirieModel>();
    }
  }
}
