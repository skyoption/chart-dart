import 'package:example/core/consts/exports.dart';
import 'package:example/l10n/app_localizations.dart';

extension OContext on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}
