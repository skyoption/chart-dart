import 'package:example/core/consts/exports.dart';

@injectable
class MainCubit extends Cubit<FlowState> {
  late final TabController controller;

  MainCubit() : super(const FlowState());

  void init(
    TabController tabController,
    initialIndex,
    Function(int pos) onChange,
  ) {
    controller = tabController;
    if (initialIndex != 0) {
      controller.animateTo(initialIndex);
    }
    controller.addListener(() {
      onChange(controller.index);
    });
  }

  void move(int value) {
    controller.animateTo(value);
  }

  @override
  Future<void> close() async {
    controller.removeListener(() {});
    controller.dispose();
    super.close();
  }
}
