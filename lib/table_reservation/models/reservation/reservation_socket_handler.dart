import '../../../flutter_foodpage_plugin.dart';

abstract class ReservationSocketHandler {
  void onSocketConnected();
  void onSocketDisconnected();
  void onSocketError(dynamic error);
  void onJoinedRoom(String roomId);
  void onNewReservationReceived(EnquirieModel reservation);
  void onNewApprovedReservationRecieved(EnquirieModel reservation);
  void onNewCustomerChatReceived(ChatMessage message);
  void onNewShopChatReceived(ChatMessage message);
}
