import 'dart:developer';

enum ResponseResult {
  success,
  failure;
}

enum ReservationStatus {
  initial(label: "Initial"),
  requested(label: "Requested"),
  modified(label: "Modified"),
  approved(label: "Approved"),
  cancelled(label: "Cancelled");

  const ReservationStatus({required this.label});

  static ReservationStatus fromLabel(String label) {
    if (label.isEmpty) return ReservationStatus.initial;

    log(label);

    return ReservationStatus.values.firstWhere((e) => e.label == label);
  }

  final String label;
}

enum APIResponseStatus { initial, loading, completed, error }
