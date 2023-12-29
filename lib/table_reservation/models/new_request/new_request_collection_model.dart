// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../enquire/enquire_model.dart';

class NewRequestCollectionModel {
  final String statusMessage;
  final String haveAdvance;
  final List<EnquirieModel> enquiries;
  final List<EnquirieModel> modifiedEnquiries;
  final List<EnquirieModel> todayCancelledEnquiries;
  NewRequestCollectionModel({
    required this.statusMessage,
    required this.haveAdvance,
    required this.enquiries,
    required this.modifiedEnquiries,
    required this.todayCancelledEnquiries,
  });

  NewRequestCollectionModel copyWith({
    String? statusMessage,
    String? haveAdvance,
    List<EnquirieModel>? enquiries,
    List<EnquirieModel>? modifiedEnquiries,
    List<EnquirieModel>? todayCancelledEnquiries,
  }) {
    return NewRequestCollectionModel(
      statusMessage: statusMessage ?? this.statusMessage,
      haveAdvance: haveAdvance ?? this.haveAdvance,
      enquiries: enquiries ?? this.enquiries,
      modifiedEnquiries: modifiedEnquiries ?? this.modifiedEnquiries,
      todayCancelledEnquiries:
          todayCancelledEnquiries ?? this.todayCancelledEnquiries,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusMessage': statusMessage,
      'haveAdvance': haveAdvance,
      'enquiries': enquiries.map((x) => x.toMap()).toList(),
      'modified_enquiries': modifiedEnquiries.map((x) => x.toMap()).toList(),
      'today_cancelled_enquiries':
          todayCancelledEnquiries.map((x) => x.toMap()).toList(),
    };
  }

  factory NewRequestCollectionModel.fromMap(Map<String, dynamic> map) {
    return NewRequestCollectionModel(
      statusMessage: map['statusMessage'] as String,
      haveAdvance: map['haveAdvance'] as String,
      enquiries: List<EnquirieModel>.from(
        (map['enquiries'] ?? []).map<EnquirieModel>(
          (x) => EnquirieModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      modifiedEnquiries: List<EnquirieModel>.from(
        (map['modified_enquiries'] ?? []).map<EnquirieModel>(
          (x) => EnquirieModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      todayCancelledEnquiries: List<EnquirieModel>.from(
        (map['today_cancelled_enquiries'] ?? []).map<EnquirieModel>(
          (x) => EnquirieModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewRequestCollectionModel.fromJson(String source) =>
      NewRequestCollectionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewRequestsCollectionModel(statusMessage: $statusMessage, haveAdvance: $haveAdvance, enquiries: $enquiries, modifiedEnquiries: $modifiedEnquiries, todayCancelledEnquiries: $todayCancelledEnquiries)';
  }

  @override
  bool operator ==(covariant NewRequestCollectionModel other) {
    if (identical(this, other)) return true;

    return other.statusMessage == statusMessage &&
        other.haveAdvance == haveAdvance &&
        listEquals(other.enquiries, enquiries) &&
        listEquals(other.modifiedEnquiries, modifiedEnquiries) &&
        listEquals(other.todayCancelledEnquiries, todayCancelledEnquiries);
  }

  @override
  int get hashCode {
    return statusMessage.hashCode ^
        haveAdvance.hashCode ^
        enquiries.hashCode ^
        modifiedEnquiries.hashCode ^
        todayCancelledEnquiries.hashCode;
  }
}
