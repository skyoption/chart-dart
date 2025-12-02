import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:example/core/consts/exports.dart';

class AppLinkProvider {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> init({required Function(Uri uri) onOpenApp}) async {
    _initDeepLinks(
      onOpenApp: onOpenApp,
    );
  }

  void dispose() {
    _linkSubscription?.cancel();
  }

  Future<void> _initDeepLinks({required Function(Uri uri) onOpenApp}) async {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      kPrint('onAppLink: $uri');
      onOpenApp(uri);
    });
  }
}
