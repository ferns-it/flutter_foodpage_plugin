enum DevelopmentMode {
  release,
  development;

  static DevelopmentMode fromName(String name) {
    return DevelopmentMode.values.firstWhere((e) => e.name == name);
  }
}

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

enum AmountStatus {
  initial(label: "Initial"),
  ready(label: "Ready"),
  received(label: "Received"),
  refunded(label: "Refund");

  const AmountStatus({required this.label});
  static AmountStatus fromLabel(String label) {
    if (label.isEmpty) return AmountStatus.initial;
    return AmountStatus.values.firstWhere((e) => e.label == label);
  }

  final String label;
}

enum AmountStatusRequest {
  ready(label: "Ready"),
  received(label: "Received");

  const AmountStatusRequest({required this.label});
  static AmountStatusRequest fromLabel(String label) {
    return AmountStatusRequest.values.firstWhere((e) => e.label == label);
  }

  final String label;
}

enum APIResponseStatus { initial, loading, completed, error }

enum PaymentMethod {
  stripe(label: "STRIPE"),
  card(label: "CASH"),
  cash(label: "CARD");

  const PaymentMethod({required this.label});

  static PaymentMethod fromLabel(String label) {
    return PaymentMethod.values.firstWhere((e) => e.label == label);
  }

  final String label;
}

enum ConditionValues {
  yes(label: "Yes"),
  no(label: "NO");

  const ConditionValues({required this.label});

  static ConditionValues fromLabel(String label) {
    return ConditionValues.values.firstWhere((e) => e.label == label);
  }

  final String label;
}
