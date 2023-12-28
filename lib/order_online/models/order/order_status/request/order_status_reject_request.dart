// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderStatusRejectRequest {
  final String rejectedReason;
  OrderStatusRejectRequest({
    required this.rejectedReason,
  });

  

  OrderStatusRejectRequest copyWith({
    String? rejectedReason,
  }) {
    return OrderStatusRejectRequest(
      rejectedReason: rejectedReason ?? this.rejectedReason,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rejectedReason': rejectedReason,
    };
  }

  factory OrderStatusRejectRequest.fromMap(Map<String, dynamic> map) {
    return OrderStatusRejectRequest(
      rejectedReason: map['rejectedReason'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusRejectRequest.fromJson(String source) => OrderStatusRejectRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderStatusRejectRequest(rejectedReason: $rejectedReason)';

  @override
  bool operator ==(covariant OrderStatusRejectRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.rejectedReason == rejectedReason;
  }

  @override
  int get hashCode => rejectedReason.hashCode;
}
