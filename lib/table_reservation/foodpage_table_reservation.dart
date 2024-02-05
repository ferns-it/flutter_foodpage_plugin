// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:flutter_foodpage_plugin/order_online/constants/api_endpoints.dart';
import 'package:flutter_foodpage_plugin/table_reservation/models/send_message/send_message_model.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/app_exception/app_exception.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/reservation_service_abstract.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/shared_preference/auth_preference.dart';
import 'package:flutter_foodpage_plugin/table_reservation/services/socket/socket_service.dart';

import 'models/history/history_request_collection_model.dart';
import 'models/reservation/reservation_notifcation_model.dart';
import 'services/shared_preference/reservation_notification_preference.dart';

class FoodpageTableReservation {
  static final _preference = AuthPreference();
  static final _reservationHistoryPreference =
      ReservationNotificationPreference();
  static late SocketService _socketService;
  static late ReservationSocketHandler _socketHandler;

  FoodpageTableReservation._internal();

  static Future<FoodpageTableReservation> create({
    required String authenticationKey,
    required String shopId,
    required ReservationSocketHandler socketHandler,
  }) async {
    _socketHandler = socketHandler;
    // Call the private constructor
    final instance = FoodpageTableReservation._internal();
    // Do initialization that requires async
    await _preference.saveAuthKeyData(authenticationKey);

    _socketService = SocketService(
      ApiEndpoints.socketBaseUrl,
      onSocketConnected: () {
        log("🟢 Socket connected!");
        _socketHandler.onSocketConnected();
      },
      onSocketDisconnected: () {
        log("🔴 Socket disconnected!");
        _socketHandler.onSocketDisconnected();
      },
      onSocketError: (error) {
        log("🔴 Socket has error! $error");
        _socketHandler.onSocketError(error);
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

  Future<ReservationNoticationHistoryModel?> notificationHistory() {
    return _reservationHistoryPreference.readReservationNotication();
  }

  static void _updateNotificationHistory(
    ReservationNotificationModel reservationNotification,
  ) async {
    final reservationHistory =
        await _reservationHistoryPreference.readReservationNotication();
    var reservations = reservationHistory?.reservations ?? [];
    reservations.removeWhere((x) {
      return x.reservationId == reservationNotification.reservationId;
    });
    final reservationNoticationHistory = ReservationNoticationHistoryModel(
      reservations: [...reservations, reservationNotification],
    );
    await _reservationHistoryPreference.updateReservationNotification(
      reservationNoticationHistory,
    );
  }

  static void _listenToSocketEvents() {
    _socketService.on(
        event: "joinedInRoom",
        onEvent: (data) {
          final roomId = "merchant-${data["id"]}";
          log("🟢 Successfully connected to room! ($roomId)");
          _socketHandler.onJoinedRoom(roomId);
        });
    _socketService.on(
        event: "new_reservation",
        onEvent: (payload) {
          final status = ReservationStatus.fromLabel(payload['status']);
          final reservation = EnquirieModel.fromMap(payload);
          final reservationNotification = ReservationNotificationModel(
            reservationId: reservation.id ?? "",
            newReservation: true,
          );

          if (status == ReservationStatus.requested) {
            _updateNotificationHistory(reservationNotification);
            _socketHandler.onNewReservationReceived(reservation.copyWith(
              notificationModel: reservationNotification,
            ));
            return;
          }
          if (status == ReservationStatus.approved) {
            _updateNotificationHistory(reservationNotification);
            _socketHandler
                .onNewApprovedReservationRecieved(reservation.copyWith(
              notificationModel: reservationNotification,
            ));
            return;
          }
        });
    _socketService.on(
        event: "message_from_shop",
        onEvent: (payload) {
          final chatMessageModel = ChatMessage.fromMap({
            ...payload['chatMessageData'],
            'reservationId': payload['reservationId'],
          }).copyWith(
            socketMessage: true,
            source: "Flutter",
          );
          _socketHandler.onNewShopChatReceived(chatMessageModel);
        });
    _socketService.on(
      event: "message_from_customer",
      onEvent: (payload) {
        final chatMessageModel = ChatMessage.fromMap({
          ...payload['chatMessageData'],
          'reservationId': payload['reservationId'],
        }).copyWith(
          socketMessage: true,
          source: "Flutter",
        );
        final reservationNotification = ReservationNotificationModel(
          reservationId: payload['reservationId'],
          newChatMessage: true,
        );
        _updateNotificationHistory(reservationNotification);
        _socketHandler.onNewCustomerChatReceived(
          chatMessageModel,
          reservationNotification,
        );
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

  Future<List<EnquirieModel>> _modifyReservationRequestsList(
      List<EnquirieModel> list) async {
    final reservationHistory =
        (await _reservationHistoryPreference.readReservationNotication())
                ?.reservations ??
            [];
    List<EnquirieModel> newModifiedList = [];
    for (var reservation in list) {
      final index = reservationHistory
          .indexWhere((element) => element.reservationId == reservation.id);
      newModifiedList.add(index == -1
          ? reservation
          : reservation.copyWith(notificationModel: reservationHistory[index]));
    }

    return List<EnquirieModel>.from(newModifiedList);
  }

  Future<APIResponse<NewRequestCollectionModel>> getNewRequests(
      {String? searchQuery}) async {
    try {
      var response = await ReservationService.instance
          .getNewRequests(searchQuery: searchQuery);
      if (response == null) {
        return _throwNotFoundException<NewRequestCollectionModel>();
      }
      final modifiedList = await _modifyReservationRequestsList(
        response.enquiries,
      );
      response = response.copyWith(enquiries: modifiedList);
      return APIResponse.completed(response);
    } on AppExceptions catch (error) {
      return APIResponse.error(error.message, exception: error);
    } catch (e) {
      return _throwUnknownErrorException<NewRequestCollectionModel>();
    }
  }

  Future<APIResponse<UpcomingRequestCollection>> getUpcomingRequests(
      {String? searchQuery}) async {
    try {
      var response = await ReservationService.instance
          .getUpcomingList(searchQuery: searchQuery);
      if (response == null) {
        return _throwNotFoundException<UpcomingRequestCollection>();
      }
      final modifiedList = await _modifyReservationRequestsList(
        response.upcomingEnquiries,
      );
      response = response.copyWith(upcomingEnquiries: modifiedList);
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
      final reservationNotification = ReservationNotificationModel(
        reservationId: reservationID,
        newReservation: false,
        newChatMessage: false,
        openedDateTime: DateTime.now(),
      );
      _updateNotificationHistory(reservationNotification);
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
