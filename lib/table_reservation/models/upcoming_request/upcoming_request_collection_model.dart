// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../enquire/enquire_model.dart';

class UpcomingRequestCollection {
  final String? statusMessage;
  final List<EnquirieModel> upcomingEnquiries;
  UpcomingRequestCollection({
    required this.statusMessage,
    required this.upcomingEnquiries,
  });

  UpcomingRequestCollection copyWith({
    String? statusMessage,
    List<EnquirieModel>? upcomingEnquiries,
  }) {
    return UpcomingRequestCollection(
      statusMessage: statusMessage ?? this.statusMessage,
      upcomingEnquiries: upcomingEnquiries ?? this.upcomingEnquiries,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusMessage': statusMessage,
      'upcomingEnquiries': upcomingEnquiries.map((x) => x.toMap()).toList(),
    };
  }

  factory UpcomingRequestCollection.fromMap(Map<String, dynamic> map) {
    return UpcomingRequestCollection(
      statusMessage:
          map['statusMessage'] != null ? map['statusMessage'] as String : null,
      upcomingEnquiries: List<EnquirieModel>.from(
        (map['upcomingEnquiries'] ?? []).map<EnquirieModel>(
          (x) => EnquirieModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpcomingRequestCollection.fromJson(String source) =>
      UpcomingRequestCollection.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UpcomingRequestCollection(statusMessage: $statusMessage, upcomingEnquiries: $upcomingEnquiries)';

  @override
  bool operator ==(covariant UpcomingRequestCollection other) {
    if (identical(this, other)) return true;

    return other.statusMessage == statusMessage &&
        listEquals(other.upcomingEnquiries, upcomingEnquiries);
  }

  @override
  int get hashCode => statusMessage.hashCode ^ upcomingEnquiries.hashCode;
}
