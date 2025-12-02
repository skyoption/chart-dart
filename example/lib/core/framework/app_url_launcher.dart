import 'package:example/core/consts/exports.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUrlLauncher {
  static Future<void> open(String url) async {
    try {
      final uri = Uri.parse(url);

      if (!await canLaunchUrl(uri)) {
        kPrint('Cannot launch URL: $url');
      }

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) await launchUrl(uri);
    } catch (e) {
      kPrint('Error launching URL $url: $e');
    }
  }
}
