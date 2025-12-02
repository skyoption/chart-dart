import 'package:example/app.dart';
import 'package:intl/intl.dart' as localization;
import 'package:example/core/consts/exports.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  FocusScopeNode get focusScope => FocusScope.of(this);

  bool isKeyboardClosed() => MediaQuery.of(this).viewInsets.bottom == 0;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isTablet {
    final shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide > 550;
  }

  TextDirection get currentTextDirection {
    if (localization.Intl.getCurrentLocale() == 'ar') {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  double get bottomInsets {
    final bottomInsets = MediaQuery.of(this).viewInsets.bottom;
    if (bottomInsets == 0) {
      return 32.0;
    }
    return bottomInsets + 12;
  }

  bool get isEnglishLanguage => localization.Intl.getCurrentLocale() == 'en';

  String leverage(int leverage) {
    return "1:$leverage";
  }

  String obfuscateEmail(String email) {
    final emailParts = email.split('@');
    final localPart = emailParts[0];
    final domainPart = emailParts[1];

    if (localPart.length < 2) {
      return email;
    }

    final firstVisiblePart = localPart.substring(0, 2);
    final obfuscatedPart = '•' * (localPart.length);
    final lastVisiblePart = localPart.substring(
      localPart.length - 2,
      localPart.length,
    );

    return '$firstVisiblePart $obfuscatedPart $lastVisiblePart@$domainPart';
  }

  String obfuscateCryptoAddress(String address) {
    if (address.length <= 11) {
      return address;
    }
    final firstVisiblePart = address.substring(0, 6);
    final lastVisiblePart = address.substring(address.length - 5);
    final obfuscatedPart = '•' * 4;

    return '$firstVisiblePart$obfuscatedPart$lastVisiblePart';
  }

  String obfuscatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 6) {
      return '$this••••••';
    }

    final countryCode = phoneNumber.startsWith('+')
        ? phoneNumber.substring(0, phoneNumber.indexOf(RegExp(r'\d')))
        : '';
    final rest = phoneNumber.replaceFirst(countryCode, '');

    if (rest.length <= 4) {
      return '$countryCode••••';
    } else {
      final visibleStart = rest.substring(0, 2);
      final visibleEnd = rest.substring(rest.length - 2);
      return '$countryCode$visibleStart••••••••$visibleEnd';
    }
  }
}

extension ColorExtension on Color {
  String asHexString({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${toARGB32().toRadixString(16).substring(3).toUpperCase()}';
  }
}

extension StringExtension on String {
  Color toHexColor({bool hasLeadingHashSign = true}) {
    String hexColor = this;
    if (hasLeadingHashSign && hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    final colorInt = int.parse(hexColor, radix: 16);
    return Color(colorInt);
  }

  String toTimeAgo() {
    final dateTime = DateTime.tryParse(this);
    if (dateTime == null) return this;

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return SkyTrading.tr.justNow;
    } else if (difference.inMinutes < 60) {
      return SkyTrading.tr.minutesAgo(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return SkyTrading.tr.hoursAgo(difference.inHours);
    } else if (difference.inDays < 7) {
      return SkyTrading.tr.daysAgo(difference.inDays);
    } else {
      return localization.DateFormat('d MMM h:mm a').format(dateTime);
    }
  }

  String socialToTimeAgo() {
    final dateTime = DateTime.tryParse(this);
    if (dateTime == null) return this;

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return SkyTrading.tr.justNow;
    } else if (difference.inMinutes < 60) {
      return SkyTrading.tr.minutes(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return SkyTrading.tr.hours(difference.inHours);
    } else if (difference.inDays < 7) {
      return SkyTrading.tr.days(difference.inDays);
    } else {
      return localization.DateFormat('d MMM h:mm a').format(dateTime);
    }
  }
}

extension FileSizeValidator on File {
  bool validateSize({double maxSizeInMB = 5.0}) {
    int maxSizeInBytes = (maxSizeInMB * 1024 * 1024).toInt();
    int fileSize = lengthSync();
    return fileSize < maxSizeInBytes;
  }
}

extension CurrencyDoFormatting on num {
  String toCurrency({String symbol = '\$'}) {
    final formatter = localization.NumberFormat.currency(
      locale: 'en_US',
      symbol: symbol,
      decimalDigits: 2,
    );
    return formatter.format(this);
  }
}

extension StringExt on String {
  bool get isVideoFile {
    if (isEmpty) return false;

    final lowerCasePath = toLowerCase();

    final videoExtensions = [
      '.mp4',
      '.webm',
      '.ogg',
      '.mov',
      '.avi',
      '.mkv',
      '.flv',
      '.wmv',
      '.m4v',
      '.mpg',
      '.mpeg',
      '.3gp',
      '.ogv',
      '.ts',
      '.mts',
      '.m2ts',
      '.divx',
      '.asf',
      '.rm',
      '.rmvb',
    ];

    return videoExtensions.any((ext) => lowerCasePath.endsWith(ext));
  }

  bool get isPhotoFile {
    if (isEmpty) return false;

    final lowerCasePath = toLowerCase();
    final photoExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

    return photoExtensions.any((ext) => lowerCasePath.endsWith(ext));
  }
}
