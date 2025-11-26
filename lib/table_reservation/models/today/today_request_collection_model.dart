import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../enquire/enquire_model.dart';

class TodayRequestCollectionModel {
  final String statusMessage;
  final bool querySearch;
  final List<EnquirieModel> upcomingEnquiries;
  TodayRequestCollectionModel({
    required this.statusMessage,
    required this.querySearch,
    required this.upcomingEnquiries,
  });

  TodayRequestCollectionModel copyWith({
    String? statusMessage,
    bool? querySearch,
    List<EnquirieModel>? upcomingEnquiries,
  }) {
    return TodayRequestCollectionModel(
      statusMessage: statusMessage ?? this.statusMessage,
      querySearch: querySearch ?? this.querySearch,
      upcomingEnquiries: upcomingEnquiries ?? this.upcomingEnquiries,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusMessage': statusMessage,
      'querySearch': querySearch,
      'upcomingEnquiries': upcomingEnquiries.map((x) => x.toMap()).toList(),
    };
  }

  factory TodayRequestCollectionModel.fromMap(Map<String, dynamic> map) {
    return TodayRequestCollectionModel(
      statusMessage: map['statusMessage'] as String,
      querySearch: map['querySearch'] as bool,
      upcomingEnquiries: List<EnquirieModel>.from(
        (map['upcomingEnquiries'] ?? []).map<EnquirieModel>(
          (x) => EnquirieModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodayRequestCollectionModel.fromJson(String source) =>
      TodayRequestCollectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodayRequestCollectionModel(statusMessage: $statusMessage, querySearch: $querySearch, upcomingEnquiries: $upcomingEnquiries)';
  }

  @override
  bool operator ==(covariant TodayRequestCollectionModel other) {
    if (identical(this, other)) return true;

    return other.statusMessage == statusMessage &&
        other.querySearch == querySearch &&
        listEquals(other.upcomingEnquiries, upcomingEnquiries);
  }

  @override
  int get hashCode {
    return statusMessage.hashCode ^
        querySearch.hashCode ^
        upcomingEnquiries.hashCode;
  }
}
