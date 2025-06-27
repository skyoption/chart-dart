import 'package:example/core/consts/exports.dart';
import 'package:example/l10n/app_localizations.dart';

extension OContext on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  FocusScopeNode get focusScope => FocusScope.of(this);

  bool get isKeyboardClosed => MediaQuery.of(this).viewInsets.bottom == 0;

  bool get isTablet {
    final shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide > 550;
  }

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
}
