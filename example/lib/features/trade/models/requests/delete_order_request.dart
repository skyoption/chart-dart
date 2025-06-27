class DeleteOrderRequest {
  final int ticket;

  DeleteOrderRequest({
    required this.ticket,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': ticket,
    };
  }
}
