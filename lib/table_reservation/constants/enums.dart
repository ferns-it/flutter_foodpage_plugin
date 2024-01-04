enum ResponseResult {
  success,
  failure;
}

enum ReservationStatus {
  approved(label: "Approved "),
  cancelled(label: "Cancelled ");

  const ReservationStatus({required this.label});

  static ReservationStatus fromLabel(String label) {
    return ReservationStatus.values.firstWhere((e) => e.label == label);
  }

  final String label;
}

enum APIResponseStatus { initial, loading, completed, error }
