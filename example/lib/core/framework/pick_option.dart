class PickOption<T> {
  final T value;
  final String label;

  const PickOption(this.value, this.label);
}

final List<PickOption<double>> chartLineSizes = [
  const PickOption(1, "1x"),
  const PickOption(2, "2x"),
  const PickOption(3, "3x"),
  const PickOption(4, "4x"),
  const PickOption(5, "5x"),
];
