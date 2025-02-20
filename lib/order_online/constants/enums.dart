enum DevMode {
  release,
  development;

  static DevMode fromName(String name) {
    return DevMode.values.firstWhere((e) => e.name == name);
  }
}

enum OnlineOrderFilter {
  all,
  $new,
  pending,
  dispatched;

  static OnlineOrderFilter fromName(String name) {
    return OnlineOrderFilter.values.firstWhere((e) => e.name == name);
  }
}

enum DineinOrderFilter {
  all,
  active,
  completed;

  static DineinOrderFilter fromName(String name) {
    return DineinOrderFilter.values.firstWhere((e) => e.name == name);
  }
}
