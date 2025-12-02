import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';

///[PositionAssetsLoseAlertCubit]
///[Implementation]
@singleton
class PositionAssetsLoseAlertCubit extends Cubit<FlowState> {
  final PositionsDataSource tradeDataSource;
  bool _isAlertActive = false;

  PositionAssetsLoseAlertCubit(this.tradeDataSource)
      : super(const FlowState(type: StateType.none));

  void execute({required double marginLevel, required double marginCallLevel}) {
    final shouldAlert = marginLevel <= marginCallLevel;
    if (shouldAlert && !_isAlertActive) {
      _isAlertActive = true;
      emit(const FlowState(type: StateType.success));
    } else if (!shouldAlert && _isAlertActive) {
      _isAlertActive = false;
      emit(const FlowState(type: StateType.none));
    } else {
      return;
    }
  }

  void stop() {
    if (_isAlertActive) {
      _isAlertActive = false;
      emit(const FlowState(type: StateType.none));
    }
  }
}
