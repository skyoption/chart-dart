class TimeEntity {
  String type;
  int from;
  int to;

  TimeEntity({
    required this.type,
    required this.from,
    required this.to,
  });
}

class FilterOption {
  final String name;
  final String type;
  final Duration? duration;

  const FilterOption(this.name, this.duration, this.type);
}
