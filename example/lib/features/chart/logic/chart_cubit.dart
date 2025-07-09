import 'dart:async';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/data_source/chart_data_source.dart';
import 'package:example/features/chart/models/requests/get_candles_request.dart';

///[ChartCubit]
///[Implementation]
@lazySingleton
class ChartCubit extends Cubit<FlowState> {
  final ChartDataSource dataSource;
  List<String> categories = [];

  ChartCubit(this.dataSource) : super(const FlowState());

  List<KLineEntity> items = [];
  CandleTimeFormat timeFrame = CandleTimeFormat.M15;
  String symbol = '';
  int offset = 0;
  double? bid, ask, low, high;

  Future<void> init() async {
    offset = 0;
    dataSource.onData(
      onAskUpdated: (symbol, value) {
        updateAskAndBid(ask: value);
      },
      onBidUpdated: (symbol, bid) {
        updateAskAndBid(bid: bid);
      },
      onReceiveRequest: (values, offset) {
        this.offset = offset;

        if (values.isNotEmpty) _setAllCandles(values, offset);
      },
    );
  }

  void updateAskAndBid({double? ask, double? bid}) {
    if (ask != null) {
      this.ask = ask;
      emit(state.copyWith(data: Data.secure, type: StateType.none));
    }
    if (bid != null) {
      _updateNewOrCurrentCandle(bid);
    }
  }

  void _setAllCandles(List<KLineEntity> values, int offset) {
    if (offset == 0) {
      low = null;
      high = null;
      items = values.toList();
    } else {
      items = [...values.reversed, ...items];
    }
    if (items.isNotEmpty) {
      bid = items.last.close;
      ask = items.last.close;
    }
    emit(state.copyWith(data: Data.secure, type: StateType.success));
  }

  Future<void> _updateNewOrCurrentCandle(double value) async {
    if (items.isEmpty) return;
    bid = value;
    if (high == null || high! < value) high = value;
    if (low == null || low! > value) low = value;
    final lastTime = items.last.time;
    int timestamp = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    final isNewCandle = dataSource.getTimeframeStart(
      timestamp,
      lastTime,
      timeFrame.name,
    );
    if (!isNewCandle) {
      final candle = items.last;
      candle.close = value;
      if (low != null) candle.low = low!;
      if (high != null) candle.high = high!;
    } else {
      low = null;
      high = null;
      items.add(
        KLineEntity(
          vol: 0,
          open: value,
          high: value,
          low: value,
          close: value,
          time: timestamp,
        ),
      );
    }
    emit(state.copyWith(data: Data.secure, type: StateType.none));
  }

  void getCandles({
    CandleTimeFormat? timeFrame,
    required String symbol,
    int offset = 0,
  }) {
    if (timeFrame != null) this.timeFrame = timeFrame;
    this.symbol = symbol;
    this.offset = offset;
    dataSource.getCandles(
      GetCandlesRequest(
        symbol: symbol,
        timeFrame: this.timeFrame.name,
        offset: offset,
      ),
    );
  }

  void setSettings({
    required CandleTimeFormat timeFrame,
    required String symbol,
    int offset = 0,
  }) {
    this.timeFrame = timeFrame;
    this.symbol = symbol;
    this.offset = offset;
  }
}
