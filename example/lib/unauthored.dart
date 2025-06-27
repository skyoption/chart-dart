import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/views/login_screen.dart';
import 'package:example/main.dart';

abstract class Unauthorized {
  Future<void> onUnauthorized();
}

@Injectable(as: Unauthorized)
class UnauthorizedImp implements Unauthorized {
  @override
  Future<void> onUnauthorized() async {
    while (SkyTrading.context.canPop) {
      SkyTrading.context.pop();
    }
    SkyTrading.context.pushReplacementNamed(LoginScreen.id);
    // getIt<CacheLoginUseCase>().execute(
    //   request: UserModel.fromJson({}),
    // );
  }
}
