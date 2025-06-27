import 'dart:async';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/data_source/chart_data_source.dart';
import 'package:example/features/chart/models/requests/get_candles_request.dart';

///[ChartCubit]
///[Implementation]
@injectable
class ChartCubit extends Cubit<FlowState> {
  final ChartDataSource dataSource;
  List<String> categories = [];

  ChartCubit(this.dataSource) : super(const FlowState());

  List<KLineEntity> items = [];
  CandleTimeFormat timeFrame = CandleTimeFormat.M1;
  String symbol = '';
  int offset = 0;
  double? bid, ask, low, high;

  Future<void> init() async {
    offset = 0;
    dataSource.onData(
      onAskUpdated: (symbol, ask) {
        this.ask = ask;
        emit(state.copyWith(data: Data.secure, type: StateType.none));
      },
      onBidUpdated: (symbol, bid) {
        if (high == null || high! < bid) {
          high = bid;
        }
        if (low == null || low! > bid) {
          low = bid;
        }
        _updateCurrent(bid);
      },
      onReceiveRequest: (values) {
        if (values.isNotEmpty) _setItems(values);
      },
    );
  }

  void _setItems(List<KLineEntity> values) {
    if (offset == 0) {
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

  Future<void> _updateCurrent(double bid) async {
    if (items.isEmpty) return;
    this.bid = bid;
    final lastTime = items.last.time;
    int timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;
    final currentTime = dataSource.getTimeframeStart(timestamp, timeFrame.name);

    if (lastTime == currentTime) {
      final candle = items.last;
      candle.close = bid;
      if (low != null) candle.low = low!;
      if (high != null) candle.high = high!;
    } else {
      low = null;
      high = null;
      final dif = currentTime - lastTime;
      items.add(
        KLineEntity(
          vol: 0,
          open: dif > 1 ? items.last.close : bid,
          high: bid,
          low: bid,
          close: bid,
          time: currentTime,
        ),
      );
    }
    emit(state.copyWith(data: Data.secure, type: StateType.none));
  }

  void getCandles({
    required CandleTimeFormat timeFrame,
    required String symbol,
    int offset = 0,
  }) {
    this.timeFrame = timeFrame;
    this.symbol = symbol;
    this.offset = offset;
    dataSource.getCandles(
      GetCandlesRequest(
        symbol: symbol,
        timeFrame: timeFrame.name,
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
