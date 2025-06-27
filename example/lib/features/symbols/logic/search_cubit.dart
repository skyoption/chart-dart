import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/data_source/search_data_source.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';

///[SearchCubit]
///[Implementation]
@injectable
class SearchCubit extends Cubit<FlowState> {
  final SearchDataSource dataSource;
  Map<String, List<SymbolModel>> categories = {};
  List<SymbolModel> searchSymbols = [];
  SymbolSearch symbolSearch = SymbolSearch.none;
  SearchCubit(
    this.dataSource,
  ) : super(const FlowState());

  void getAllSymbols() {
    dataSource.getAllSymbols();
    dataSource.onData(
      onReceiveRequest: (value) {
        categories = value;
        emit(state.copyWith(data: Data.secure));
      },
    );
  }

  void searchForSymbol(String query) {
    if (query.isEmpty) {
      searchSymbols = [];
      symbolSearch = SymbolSearch.none;
    } else {
      searchSymbols = categories.values
          .expand((symbols) => symbols)
          .where((symbol) =>
              symbol.name.toLowerCase().contains(query.toLowerCase()) ||
              symbol.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
      if (searchSymbols.isEmpty) {
        symbolSearch = SymbolSearch.emptyResults;
      } else {
        symbolSearch = SymbolSearch.hasResults;
      }
    }
    emit(state.copyWith(data: Data.secure));
  }

  bool isFav(String symbol) {
    return dataSource.symbols[symbol] != null;
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}

enum SymbolSearch { none, hasResults, emptyResults }
