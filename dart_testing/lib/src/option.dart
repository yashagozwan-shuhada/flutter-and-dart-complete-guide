class Option<T> {
  const Option({
    required this.label,
    required this.value,
  });

  final String label;
  final T value;
}
