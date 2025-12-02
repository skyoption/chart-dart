import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/jsons.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/core/framework/app_cubit.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/features/main/logic/connect_cubit.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamController<String> versionController = StreamController();
  late final ConnectCubit loginCubit;
  late final AppCubit appCubit;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String version = packageInfo.version;
      versionController.add(version);
    });
    loginCubit = context.read<ConnectCubit>();
    appCubit = context.read<AppCubit>();
    _afterSplashNavigation();
  }

  Future<void> _afterSplashNavigation() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = await loginCubit.userLoggedIn;
    if (user != null) {
      await getIt<ObjectBox>().create(user.id);
      if (mounted) context.router.replace(AuthenticatedRoutes());
    } else {
      if (mounted) context.router.replace(UnAuthenticatedRoutes());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MLottieImage(
              name: Jsons.whiteModLogo,
              width: double.infinity,
              height: context.width,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            SizedBox(height: context.height * 0.15),
            StreamBuilder<String>(
              stream: versionController.stream,
              builder: (context, snapShot) {
                if (snapShot.data != null) {
                  return MText(
                    text: context.tr.version(snapShot.data.toString()),
                    size: FoontSize.font16,
                    color: AppColors.secondColor,
                    weight: FontWeight.w500,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
// final res = getIt<GetBoardingStatusUseCase>().execute();
// res.right((data) {
//   if (data) {
//     final res = getIt<GetTokenUseCase>().execute();
//     res.right((data) {
//       if (data.isEmpty) {
//         context.pushNamedAndRemoveUntil(LoginScreen.id);
//       } else {
//         context.pushNamedAndRemoveUntil(MainScreen.id);
//       }
//     });
//   } else {
//     context.pushNamedAndRemoveUntil(BoardingScreen.id);
//   }
// });
