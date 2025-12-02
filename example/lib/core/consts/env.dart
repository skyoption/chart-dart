// import 'package:example/app.dart';
// import 'package:example/core/consts/exports.dart';

// import 'package:example/core/env/app_env.dart';
// import 'package:example/core/router/app_router.dart';
// import 'package:example/injection/injectable.dart';

// @LazySingleton(as: Env)
// class EnvImp extends Env {
//   @override
//   BuildContext get mainContext => SkyTrading.context;

//   @override
//   GlobalKey<NavigatorState> get navigatorKey => getIt<AppRouter>().navigatorKey;

//   @override
//   Function get onUnauthorized => () {
//         SkyTrading.context.replaceRoute(
//           UnAuthenticatedRoutes(children: [LoginRoute()]),
//         );
//       };

//   @override
//   Function get openNotification => () {};
//   @override
//   String get myFatoorahApiKey =>
//       'BHPGaX3TwmhPnUNah6NVqxDvPc-fbnER2bp0fWlHyOuTSkBfheHPjdLjNO8lXGQ1oTH7DZ6DkdiQEmDgweYBGkkqmM5YEuBkw5-cyNOcvKWQuUD9-7bJXt-3J3izdb4IE3habADm9F6cMB_JJTbUnG2rQ2sRdhFMav2JhpfTXgsjKe_dchOAuJAim4Aqn-h7hgLOO-jIPr_ck5_3J-FsssLq9xpV1t-FVbB665F9oDYzgm3LEhu0nQT5GJTkFoYFvmy5AOMKSwpgsRTIVwCRUphHBBXNGOYs0qZ3xPE5VgJiXQ_ivRDxiwp73EdMd-Dg-clPg6kCpaRhkSlFEeoJC_X0WGj2wGVSh1r708nHfn0VvUGxWWnpyZaelF5kE65ZUBAF7aXo4X3eikV7t5b78pudh1-PEBPJGfio1qaYpRJHvOIYI67Y5tLYDx_tYvkgQEm9xKMGWZrBD9QqM7BTM5W192ccm_CiCMEwoaK3sYG8NYzRXmVXq66-JqZ8sUmw6IuiLWJ6UKE7sCXVQZ0Cst-ulU7rBar87rqe5TT0XL-HatPgrCwWkrP_L_l0hEO828pkpGfHUNAu_yzLVzUhr-pQIebdYG0QB78I7hmoxvxwXE7t6SJDudaDAkqrEDg4c4y0_tN0_vNU9TUgApIQ4shPQgf0mzZpB_KgFa-17CRGXn';

//   @override
//   // String get URL => 'https://api-mysky-dev.skyoption.app';
//   // String get URL => 'https://back.skyoption.app';
//   String get URL => 'https://sky5superadmin.api.skyoption.app';
//   @override
//   String get SOCKETURL => 'wss://sky5alpha-london.skyoption.app:46666/ws';
//   @override
//   String get photoBaseUrl =>
//       "https://skyoptionlondons3.s3.eu-west-2.amazonaws.com";
//   @override
//   String get socialAttachmentBaseUrl =>
//       "https://skyoptionlondons3.s3.eu-west-2.amazonaws.com";
//   @override
//   String get appTerms => "https://skyoption.tech/terms";
//   @override
//   String get appPrivacyAndPolicy => "https://skyoption.tech/privacypolicy";

//   @override
//   String get deepLinkUrl => "deeplink.skyoption.app";
//   @override
//   String get appName => "Sky Trade";
//   @override
//   String get CHATSOCKETURL => 'wss://back.skyoption.app/api/v0/socket.io';

//   @override
//   String get googlePayMerchantId => "000000000000000";
//   @override
//   String get googlePayMerchantName => "My Sky";
// }
