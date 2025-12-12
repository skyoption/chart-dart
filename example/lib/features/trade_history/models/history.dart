import 'package:example/features/trade_history/models/history_position_entity.dart';

class History {
  int id;
  String date;
  double amount;
  double swap;
  double commission;
  String comment;
  String source;
  String type;
  String isA = 'found';

  History({
    required this.id,
    required this.amount,
    required this.type,
    required this.comment,
    required this.source,
    required this.date,
    required this.commission,
    required this.swap,
  });
}

extension OnHistory on History {
  HistoryPositionEntity toPosition() {
    return HistoryPositionEntity(
      swap: swap,
      date: date,
      amount: amount,
      commission: commission,
      type: type,
      comment: comment,
      source: source,
      id: id,
      isA: 'found',
      volumeCurrent: 0,
      tp: 0,
      sl: 0,
      margin: 0,
      openPrice: 0,
      volumeInit: 0,
      closePrice: 0,
      openTime: '',
      closeTime: '',
      symbol: '',
      direction: '',
    );
  }
}
