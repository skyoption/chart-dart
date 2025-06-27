import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

@injectable
class FirebaseAnalyticsService {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver appAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  Future setUserId({required String id}) async {
    await analytics.setUserId(id: id);
    kPrint('setUserId succeeded');
  }

  Future setUserProperties({
    required String? id,
    required String? loginType,
    required String? userRole,
  }) async {
    await analytics.setUserId(id: id);

    await analytics.setUserProperty(name: 'login_type', value: loginType);

    await analytics.setUserProperty(name: 'user_role', value: userRole);
  }

  Future logLogin() async {
    await analytics.logLogin(loginMethod: 'email');
  }

  Future logAppOpen() async {
    await analytics.logAppOpen();
    kPrint('AppOpen succeeded');
  }

  Future logSignUp() async {
    await analytics.logSignUp(signUpMethod: 'email');
  }
}
