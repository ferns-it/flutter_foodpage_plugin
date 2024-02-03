import 'package:shared_preferences/shared_preferences.dart';

import '../../models/reservation/reservation_notifcation_model.dart';

class ReservationNotificationPreference {
  String get storageKey => 'reservation_history';

  Future<bool> updateReservationNotification(
      ReservationNoticationHistoryModel reservationNoticationHistory) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString(
        storageKey, reservationNoticationHistory.toJson());
  }

  Future<ReservationNoticationHistoryModel?> readReservationNotication() async {
    final instance = await SharedPreferences.getInstance();
    final data = instance.getString(storageKey);
    if (data == null) return null;
    return ReservationNoticationHistoryModel.fromJson(data);
  }

  Future<bool> clearReservationHistory() async {
    final instance = await SharedPreferences.getInstance();
    return instance.clear();
  }
}
