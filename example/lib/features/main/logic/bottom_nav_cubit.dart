import 'package:example/core/consts/exports.dart';

@injectable
class BottomNavCubit extends Cubit<FlowState> {
  int index = 0;
  double space = 0;
  AnimationController? controller;
  Animation<double>? tweenPosition;

  BottomNavCubit() : super(const FlowState());

  Future<void> init(
    AnimationController animationController,
    double width,
  ) async {
    space = width * 0.25;
    if (controller == null) {
      controller = animationController
        ..duration = const Duration(milliseconds: 200);
      tweenPosition =
          Tween<double>(begin: 0, end: space * 0.25).animate(controller!)
            ..addListener(() {
              emit(state.copyWith(data: Data.secure));
            });
      emit(state.copyWith(data: Data.secure));
      controller!.forward();
    }
  }

  Future<void> moveTo(value) async {
    if (index != value) {
      tweenPosition =
          Tween<double>(begin: _position(index), end: _position(value))
              .animate(controller!);
      index = value;
      await controller!.forward(from: 0);
    }
  }

  double _position(index) {
    return (index + 1) * space - (space * 0.75);
  }

  @override
  Future<void> close() {
    controller?.removeListener(() {});
    controller?.dispose();
    return super.close();
  }
}
