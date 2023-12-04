// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderStatusDispatchRequest {
  final String message;
  OrderStatusDispatchRequest({
    required this.message,
  });

  OrderStatusDispatchRequest copyWith({
    String? message,
  }) {
    return OrderStatusDispatchRequest(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory OrderStatusDispatchRequest.fromMap(Map<String, dynamic> map) {
    return OrderStatusDispatchRequest(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusDispatchRequest.fromJson(String source) => OrderStatusDispatchRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderStatusDispatchRequest(message: $message)';

  @override
  bool operator ==(covariant OrderStatusDispatchRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
