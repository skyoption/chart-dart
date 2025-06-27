import 'package:mwidgets/mwidgets.dart';

import '../consts/exports.dart';

class CubitObserver extends BlocObserver {

  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    kPrint('onCreate -- ${bloc.runtimeType}');
  }


  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    kPrint('onChange -- ${bloc.runtimeType}, $change');
  }


  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    kPrint('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }


  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    kPrint('onClose -- ${bloc.runtimeType}');
  }
}
