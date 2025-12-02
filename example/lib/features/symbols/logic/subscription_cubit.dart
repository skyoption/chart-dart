import 'package:example/core/consts/exports.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/symbols/data_source/search_data_source.dart';
import 'package:example/injection/injectable.dart';

///[SubscriptionCubit]
///[Implementation]
@injectable
class SubscriptionCubit extends Cubit<FlowState> {
  final SearchDataSource dataSource;
  bool isSubscribed = false;

  SubscriptionCubit(
    this.dataSource,
  ) : super(const FlowState());

  void setInitial(bool value) {
    isSubscribed = value;
    emit(state.copyWith(data: Data.secure));
  }

  void subscription(symbol) {
    if (isSubscribed) {
      getIt<TradingLogsCubit>().log("Unsubscribed From $symbol Symbol");
      dataSource.unsubscribeSymbol(symbol);
    } else {
      getIt<TradingLogsCubit>().log("Subscribed To $symbol Symbol");
      dataSource.subscribeSymbol(symbol);
    }
    isSubscribed = !isSubscribed;
    emit(state.copyWith(data: Data.secure));
  }
}
