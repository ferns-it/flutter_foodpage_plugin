// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderStatusAcceptRequest {
  final String message;
  OrderStatusAcceptRequest({
    required this.message,
  });

  OrderStatusAcceptRequest copyWith({
    String? message,
  }) {
    return OrderStatusAcceptRequest(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory OrderStatusAcceptRequest.fromMap(Map<String, dynamic> map) {
    return OrderStatusAcceptRequest(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusAcceptRequest.fromJson(String source) => OrderStatusAcceptRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderStatusAcceptRequest(message: $message)';

  @override
  bool operator ==(covariant OrderStatusAcceptRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
