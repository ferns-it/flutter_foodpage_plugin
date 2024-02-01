// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:flutter_foodpage_plugin/order_online/constants/api_endpoints.dart';
import 'package:flutter_foodpage_plugin/table_reservation/models/send_message/send_message_model.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/app_exception/app_exception.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/reservation_service_abstract.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/shared_preference/auth_preference.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/socket/socket_service.dart';

import 'models/history/history_request_collection_model.dart';

class FoodpageTableReservation {
  static final _preference = AuthPreference();
  static late SocketService _socketService;

  FoodpageTableReservation._internal();

  static Future<FoodpageTableReservation> create({
    required String authenticationKey,
    required String shopId,
  }) async {
    // Call the private constructor
    final instance = FoodpageTableReservation._internal();
    // Do initialization that requires async
    await _preference.saveAuthKeyData(authenticationKey);

    _socketService = SocketService(
      ApiEndpoints.socketBaseUrl,
      onSocketConnected: () {
        log("🟢 Socket connected!");
      },
      onSocketDisconnected: () {
        log("🔴 Socket disconnected!");
      },
      onSocketError: (error) {
        log("🔴 Socket has error! $error");
      },
    );

    _joinSocketRoom(shopId);
    _listenToSocketEvents();

    // Return the fully initialized object
    return instance;
  }

  static void _joinSocketRoom(String shopId) async {
    _socketService.emit(event: 'join-merchant-room', data: shopId);
  }

  static void _listenToSocketEvents() {
    _socketService.on(
        event: "joinedInRoom",
        onEvent: (room) {
          log("🟢 Successfully connected to room (response):  $room");
        });
    _socketService.on(
        event: "new_reservation",
        onEvent: (payload) {
          log(payload.toString());
        });
    _socketService.on(
        event: "message_from_shop",
        onEvent: (payload) {
          log(payload.toString());

          var chatMessageData = payload['chatMessageData'];
          chatMessageData['reservationId'] = payload['reservationId'];
          var chatMessageModel = ChatMessage.fromMap(chatMessageData);
          chatMessageData = chatMessageModel.copyWith(socketMessage: true);
          inspect(chatMessageModel);
        });
    _socketService.on(
      event: "message_from_customer",
      onEvent: (payload) {
        log(payload.toString());

        var chatMessageData = payload['chatMessageData'];
        chatMessageData['reservationId'] = payload['reservationId'];
        var chatMessageModel = ChatMessage.fromMap(chatMessageData);
        chatMessageData = chatMessageModel.copyWith(socketMessage: true);
        inspect(chatMessageModel);
      },
    );
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

  Future<APIResponse<NewRequestCollectionModel>> getNewRequests(
      {String? searchQuery}) async {
    // try {
    final response = await ReservationService.instance
        .getNewRequests(searchQuery: searchQuery);
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

  Future<APIResponse<UpcomingRequestCollection>> getUpcomingRequests(
      {String? searchQuery}) async {
    try {
      final response = await ReservationService.instance
          .getUpcomingList(searchQuery: searchQuery);
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
      getReservationHistory({String? searchQuery}) async {
    try {
      final response = await ReservationService.instance.getReservationHistory(
        searchQuery: searchQuery,
      );
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

  Future<ResponseResult> approveOrCancelReservation(
    ApproveOrCancelRequestModel payload,
  ) async {
    try {
      final response =
          await ReservationService.instance.approveOrCancelReservation(
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

  Future<APIResponse<EnquirieModel>> newReservation(
      NewReservationModel reservation) async {
    try {
      final response = await ReservationService.instance.newReservation(
        reservation,
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
