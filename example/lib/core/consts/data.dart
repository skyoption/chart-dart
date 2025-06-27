import 'dart:math';

import 'package:intl/intl.dart';

class Data {
  ///[inTEST]
  ///[set range one]
  // static int range = 1;

  ///[inLive]
  ///[set range one]
  static int range = 80000;

  static String get secure {
    return Random.secure().nextInt(range).toString();
  }

  static int get secureInt {
    return Random.secure().nextInt(range);
  }
}

class Password {
  static String generatePassword({
    bool isWithLetters = true,
    bool isWithUppercase = true,
    bool isWithNumbers = true,
    bool isWithSpecial = true,
    double numberCharPassword = 9,
  }) {
    //Define the allowed chars to use in the password
    String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
    String upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String numbers = "0123456789";
    String special = "@#=+!£\\\$%&?";

    //Create the empty string that will contain the allowed chars
    String allowedChars = "";

    //Put chars on the allowed ones based on the input values
    allowedChars += (isWithLetters ? lowerCaseLetters : '');
    allowedChars += (isWithUppercase ? upperCaseLetters : '');
    allowedChars += (isWithNumbers ? numbers : '');
    allowedChars += (isWithSpecial ? special : '');

    int i = 0;
    String result = "";

    //Create password
    while (i < numberCharPassword.round()) {
      //Get random int
      int randomInt = Random.secure().nextInt(allowedChars.length);

      //Get random char and append it to the password
      result += allowedChars[randomInt];
      i++;
    }

    return result;
  }
}

class Validation {
  static RegExp regex = RegExp(
      r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~])(?!.*\s).{8,}$');

  static String? isStrongPassword({
    required String password,
    required String errorMessage,
  }) {
    if (!regex.hasMatch(password)) {
      return errorMessage;
    }
    return null;
  }
}

extension OnnString on String {
  String get toLastTime {
    return DateFormat('yyyy-MM-dd hh:mm:ss a')
        .format(DateTime.parse(this).toLocal());
  }

  String get toLastTimeOnly {
    return DateFormat('hh:mm:ss a').format(DateTime.parse(this).toLocal());
  }

  String get toLastTimeMMSS {
    return DateFormat('mm:ss').format(DateTime.parse(this).toLocal());
  }
}

extension OnnDateTime on DateTime {
  int get toStartTime {
    return copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
      isUtc: true,
    ).millisecondsSinceEpoch;
  }

  int get toEndTime {
    return copyWith(
      hour: 23,
      minute: 59,
      second: 59,
      isUtc: true,
    ).millisecondsSinceEpoch;
  }
}

extension OnInt on int {
  String get toLastTime {
    return DateFormat('yyyy-MM-dd hh:mm:ss')
        .format(DateTime.fromMillisecondsSinceEpoch(this));
  }

  String get toLastTimeOnly {
    return DateFormat('hh:mm:ss')
        .format(DateTime.fromMillisecondsSinceEpoch(this));
  }

  DateTime toDateTime({bool isUtc = true}) {
    return DateTime.fromMillisecondsSinceEpoch(this, isUtc: isUtc);
  }

  String toDateFromMilliseconds({bool isUtc = true}) {
    return DateFormat('yyyy-MM-dd')
        .format(DateTime.fromMillisecondsSinceEpoch(this, isUtc: isUtc));
  }
}
