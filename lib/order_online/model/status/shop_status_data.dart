// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShopStatusData {
  final String? messages;
  ShopStatusData({
    this.messages,
  });

  ShopStatusData copyWith({
    String? messages,
  }) {
    return ShopStatusData(
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messages': messages,
    };
  }

  factory ShopStatusData.fromMap(Map<String, dynamic> map) {
    return ShopStatusData(
      messages: map['messages'] != null ? map['messages'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopStatusData.fromJson(String source) => ShopStatusData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ShopStatusData(messages: $messages)';

  @override
  bool operator ==(covariant ShopStatusData other) {
    if (identical(this, other)) return true;
  
    return 
      other.messages == messages;
  }

  @override
  int get hashCode => messages.hashCode;
}
