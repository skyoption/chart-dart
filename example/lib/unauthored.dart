import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/app_prefs.dart';
import 'package:example/injection/injectable.dart';

abstract class Unauthorized {
  Future<void> onUnauthorized();
}

@Injectable(as: Unauthorized)
class UnauthorizedImp implements Unauthorized {
  @override
  Future<void> onUnauthorized() async {
    await getIt<AppPreferences>().putData(Constants.USERCACHED, '');
    if (SkyTrading.context.mounted) {
      SkyTrading.context.replaceRoute(
        UnAuthenticatedRoutes(children: [LoginRoute()]),
      );
    }
  }
}
