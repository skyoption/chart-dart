import 'dart:async';

import 'package:candle_chart/k_chart_plus.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/symbol_sort.dart';
import 'package:example/features/chart/data_source/chart_data_source.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/features/symbols/data_source/quotes_data_source.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/main.dart';

///[QuotesCubit]
///[Implementation]
@singleton
class QuotesCubit extends Cubit<FlowState> {
  final QuotesDataSource dataSource;
  final ChartCubit chartCubit;
  final ChartDataSource chartDataSource;
  List<String> categories = [];
  String symbol = '';
  CandleTimeFormat timeframe = CandleTimeFormat.M15;

  QuotesCubit(this.dataSource, this.chartDataSource, this.chartCubit)
      : super(const FlowState()) {
    chartDataSource.setDefaultSymbol(
      value: currentSymbol,
      onAskAndBidUpdated: updateAskAndBid,
    );
  }

  Future<void> updateAskAndBid(String symbol, double ask, double bid) async {
    kPrint("updateAskAndBid: $symbol, $ask, $bid");
    if (symbol != currentSymbol.value?.symbol) return;
    chartCubit.ask = null;
    chartCubit.bid = null;
    await Future.delayed(const Duration(milliseconds: 300));
    chartCubit.updateAskAndBid(ask: ask, bid: bid);
  }

  @override
  Future<void> close() {
    currentSymbol.removeListener(() {});
    return super.close();
  }

  SymbolSortConfig currentSortConfig = const SymbolSortConfig(
    criteria: SymbolSortCriteria.sortByName,
    isAscending: false,
    hideToggleIcon: false,
  );

  List<SymbolEntity> symbols = [];
  List<SymbolEntity> noFilterSymbols = [];

  ValueNotifier<SymbolEntity?> currentSymbol = ValueNotifier<SymbolEntity?>(
    null,
  );

  void setCurrentSymbol(SymbolEntity item) {
    currentSymbol.value = getSymbol(item.symbol);
  }

  SymbolEntity? getSymbol(String item) {
    return dataSource.getSymbol(item);
  }

  String type = 'All';

  Future<void> setType(String type) async {
    this.type = type;
    _filter();
    emit(state.copyWith(data: Data.secure));
  }

  void _filter() async {
    if (type == "All") {
      symbols = noFilterSymbols;
    } else if (type == "Favorites") {
      symbols = noFilterSymbols.where((item) => item.isFav).toList();
    } else {
      symbols = noFilterSymbols.where((item) => item.sector == type).toList();
    }
    if (symbol.isNotEmpty) {
      final item = getSymbol(symbol);
      if (item != null) {
        currentSymbol.value = item;
      } else if (symbols.isNotEmpty) {
        currentSymbol.value = symbols[0];
      }
    } else if (currentSymbol.value != null) {
      currentSymbol.value = getSymbol(currentSymbol.value!.symbol);
    } else if (symbols.isNotEmpty) {
      currentSymbol.value = symbols[0];
    }
  }

  void setTimeframe(CandleTimeFormat frame) {
    timeframe = frame;
    kPrint(timeframe);
    chartDataSource.setCandleTimeFormat(timeframe);
  }

  void setSymbol(String symbol) {
    this.symbol = symbol;
  }

  Future<void> init() async {
    symbols.clear();
    noFilterSymbols.clear();
    dataSource.onData(
      onReceiveRequest: (symbols, categories) {
        this.symbols = symbols;
        noFilterSymbols = symbols;
        this.categories = categories;
        _filter();
        emit(state.copyWith(data: this.symbols));
      },
      onUpdateSymbol: (items) {
        symbols = items;
        noFilterSymbols = items;
        _filter();
        emit(state.copyWith(data: symbols));
      },
      onRemoveSymbol: (SymbolEntity item) {
        symbols.remove(item);
        noFilterSymbols.remove(item);
        _filter();
        emit(state.copyWith(data: symbols));
      },
    );
  }

  Future<void> getCachedSymbols() async {
    symbols = await dataSource.getCachedSymbols();
    noFilterSymbols = await dataSource.getCachedSymbols();
    categories = dataSource.categories;
    _filter();
    emit(state.copyWith(data: symbols));
  }

  Future<void> sendToSubscribe() async {
    await dataSource.sendToSubscribe();
  }

  void onSwitchAccount(List<String> symbols) {
    dataSource.onSwitchAccount(symbols);
  }

  void setFav(SymbolEntity symbol, bool isFav) {
    dataSource.setSymbolFav(item: symbol, value: isFav);
    getIt<TradingLogsCubit>().log(
      "Symbol: ${symbol.symbol} was set as favorite List",
    );
  }

  void removeSymbol(SymbolEntity symbol) {
    dataSource.unsubscribeSymbol(symbol.symbol);
  }

  void reorderSymbols(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final item = symbols.removeAt(oldIndex);
    symbols.insert(newIndex, item);

    final start = oldIndex < newIndex ? oldIndex : newIndex;
    final end = oldIndex > newIndex ? oldIndex : newIndex;

    for (int i = start; i <= end; i++) {
      symbols[i].index = i;
      dataSource.updateSymbol(symbols[i]);
    }
    dataSource.reorderMappedSymbols();
    emit(state.copyWith(data: symbols));
  }

  void sortSymbols(SymbolSortConfig config) {
    currentSortConfig = config;
    switch (config.criteria) {
      case SymbolSortCriteria.sortByName:
        symbols.sort(
          (a, b) => config.isAscending
              ? a.symbol.compareTo(b.symbol)
              : b.symbol.compareTo(a.symbol),
        );

      case SymbolSortCriteria.activeTrades:
        final activeSymbols = SkyTrading.context.read<PositionsCubit>().symbols;
        activeSymbols.sort((a, b) => a.compareTo(b));
        symbols.sort((a, b) {
          // Check if symbols are in active positions
          final aIsActive = activeSymbols.contains(a.symbol);
          final bIsActive = activeSymbols.contains(b.symbol);
          if (aIsActive && bIsActive) {
            // If both are active, sort alphabetically (A-Z)
            return a.symbol.compareTo(b.symbol);
          } else if (aIsActive) {
            // Active symbols come first
            return -1;
          } else if (bIsActive) {
            return 1;
          } else {
            // If neither is active, sort alphabetically (A-Z)
            return a.symbol.compareTo(b.symbol);
          }
        });
    }
    _updateSymbolIndex();
    emit(state.copyWith(data: symbols));
  }

  void _updateSymbolIndex() {
    for (int i = 0; i < symbols.length; i++) {
      symbols[i].index = i;
      dataSource.updateSymbol(symbols[i]);
    }
    dataSource.reorderMappedSymbols();
  }

  void dispose() {
    currentSymbol.dispose();
    dataSource.close();
  }
}
