import 'dart:convert';

class SendMessageModel {
  final int reservationId;
  final String message;
  final String source = 'Flutter';
  SendMessageModel({
    required this.reservationId,
    required this.message,
  });

  SendMessageModel copyWith({
    int? reservationId,
    String? message,
    String? source,
  }) {
    return SendMessageModel(
      reservationId: reservationId ?? this.reservationId,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reservationId': reservationId,
      'message': message,
      'source': source,
    };
  }

  factory SendMessageModel.fromMap(Map<String, dynamic> map) {
    return SendMessageModel(
      reservationId: map['reservationId'].toInt() as int,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendMessageModel.fromJson(String source) =>
      SendMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SendMessageModel(reservationId: $reservationId, message: $message, source: $source)';

  @override
  bool operator ==(covariant SendMessageModel other) {
    if (identical(this, other)) return true;

    return other.reservationId == reservationId &&
        other.message == message &&
        other.source == source;
  }

  @override
  int get hashCode =>
      reservationId.hashCode ^ message.hashCode ^ source.hashCode;
}
