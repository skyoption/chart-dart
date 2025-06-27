import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/jsons.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/auth/views/login_screen.dart';
import 'package:example/features/main/views/main_screen.dart';
import 'package:example/injection/injectable.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamController<String> versionController = StreamController();
  late final ConnectCubit loginCubit;

  @override
  void initState() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String version = packageInfo.version;
      versionController.add(version);
    });
    loginCubit = context.read<ConnectCubit>();
    _checkCredentials();
    super.initState();
  }

  Future<void> _checkCredentials() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = await loginCubit.userLoggedIn;
    if (user != null) {
      await getIt<ObjectBox>().create(user.id);
      if (mounted) {
        context.pushNamedAndRemoveUntil(MainScreen.id);
      }
    } else {
      if (mounted) context.pushNamedAndRemoveUntil(LoginScreen.id);
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
