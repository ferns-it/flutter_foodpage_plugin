enum ResponseResult {
  success,
  failure;
}

enum ReservationStatusUpdate {
  cancelled(label: "Cancelled"),
  approved(label: "Approved");

  const ReservationStatusUpdate({required this.label});
  static ReservationStatusUpdate fromLabel(String label) {
    return ReservationStatusUpdate.values.firstWhere((e) => e.label == label);
  }

  final String label;
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

    return ReservationStatus.values.firstWhere((e) => e.label == label);
  }

  final String label;
}

enum APIResponseStatus { initial, loading, completed, error }
