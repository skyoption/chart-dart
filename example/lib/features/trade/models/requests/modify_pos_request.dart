class ModifyPosRequest {
  final int id;
  final double sl;
  final double tp;

  ModifyPosRequest({
    required this.id,
    required this.sl,
    required this.tp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sl': sl,
      'tp': tp,
    };
  }
}
