import 'package:example/core/consts/exports.dart';
import 'package:example/main.dart';

import '../views/widgets/boarding_item_widget.dart';

@injectable
class BoardingCubit extends Cubit<FlowState> {
  late final TabController tabController;

  int index = 0;

  final boards = [
    Boarding(
      icon: Pngs.firstSlider,
      title: SkyTrading.tr.welcomeToSky5,
      description: SkyTrading.tr.welcomeDescription,
    ),
    Boarding(
      icon: Pngs.secondSlider,
      title: SkyTrading.tr.globalMarketsAtYourFingertips,
      description: SkyTrading.tr.globalMarketsDescription,
    ),
    Boarding(
      icon: Pngs.thirdSlider,
      title: SkyTrading.tr.advancedTradingTools,
      description: SkyTrading.tr.advancedToolsDescription,
    ),
    Boarding(
      icon: Pngs.fourdSlider,
      title: SkyTrading.tr.realTimeMarketInsights,
      description: SkyTrading.tr.realTimeInsightsDescription,
    ),
  ];

  BoardingCubit() : super(const FlowState());

  Future<void> setUp(TabController controller) async {
    tabController = controller;
    tabController.addListener(() {
      index = tabController.index;
      emit(state.copyWith(data: index));
    });
  }

  void next(Function onFinished) {
    if (index < 3) {
      index++;
      _go(index);
      emit(state.copyWith(data: index));
    } else {
      onFinished();
    }
  }

  void back() {
    if (index > 0) {
      index--;
      _go(index);
      emit(state.copyWith(data: index));
    }
  }

  void _go(int index) {
    tabController.animateTo(index,
        duration: const Duration(milliseconds: 1000), curve: Curves.linear);
  }

  @override
  Future<void> close() {
    tabController.removeListener(() {});
    tabController.dispose();
    return super.close();
  }
}
