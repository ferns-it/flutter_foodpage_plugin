// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';

class ReservationHistoryRequestCollectionModel {
  final String statusMessage;
  final List<EnquirieModel> historyList;
  ReservationHistoryRequestCollectionModel({
    required this.statusMessage,
    required this.historyList,
  });

  ReservationHistoryRequestCollectionModel copyWith({
    String? statusMessage,
    List<EnquirieModel>? historyList,
  }) {
    return ReservationHistoryRequestCollectionModel(
      statusMessage: statusMessage ?? this.statusMessage,
      historyList: historyList ?? this.historyList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusMessage': statusMessage,
      'historyList': historyList.map((x) => x.toMap()).toList(),
    };
  }

  factory ReservationHistoryRequestCollectionModel.fromMap(
      Map<String, dynamic> map) {
    return ReservationHistoryRequestCollectionModel(
      statusMessage: map['statusMessage'] as String,
      historyList: List<EnquirieModel>.from(
        (map['historyList'] ?? []).map<EnquirieModel>(
          (x) => EnquirieModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationHistoryRequestCollectionModel.fromJson(String source) =>
      ReservationHistoryRequestCollectionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReservationHistoryRequestCollectionModel(statusMessage: $statusMessage, historyList: $historyList)';

  @override
  bool operator ==(covariant ReservationHistoryRequestCollectionModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.statusMessage == statusMessage &&
        listEquals(other.historyList, historyList);
  }

  @override
  int get hashCode => statusMessage.hashCode ^ historyList.hashCode;
}
