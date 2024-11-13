
import 'dart:math';

import 'package:flutter/material.dart';

/// Render Rectangle
class RenderRect {
  Rect mRect;
  double mMaxValue = double.minPositive, mMinValue = double.maxFinite;

  RenderRect(this.mRect);
}

//# 科学下标
TextSpan formatValueSpan(double? value, TextStyle style) {
  if (value == 0.00) {
    return TextSpan(text: ' 0.00', style: style);
    // return TextSpan(text: '\$ 0.00', style: style);
  }

  String _dollarValue(double value, int decimals) {
    return '' + value.toStringAsFixed(decimals);
    // return '\$' + value.toStringAsFixed(decimals);
  }

  if (value != null && value < 0.01) {
    final temp = value.toStringAsFixed(8).split('.');
    if (temp.length != 2) {
      return TextSpan(text: _dollarValue(value, 2), style: style);
    }
    var index = 0;
    for (; index < temp[1].length; index++) {
      if (temp[1][index] != '0') {
        break;
      }
    }
    final remain = temp[1].replaceRange(0, index, '');
    return TextSpan(
      text: '0.0',
      // text: '\$0.0',
      children: [
        ///	•	FontFeature.alternativeFractions(): 使用替代分数样式。
        // 	•	FontFeature.caseSensitiveForms(): 使用大小写敏感表单样式。
        // 	•	FontFeature.characterVariant(int value): 使用字符变体。
        // 	•	FontFeature.contextualAlternates(): 使用上下文替代样式。
        // 	•	FontFeature.denominator(): 使用分母样式。
        // 	•	FontFeature.fractions(): 使用分数样式。
        // 	•	FontFeature.historicalForms(): 使用历史表单样式。
        // 	•	FontFeature.liningFigures(): 使用等线数字。
        // 	•	FontFeature.localeAware(value): 使用特定语言环境的字体特性。
        // 	•	FontFeature.notationalForms(int value): 使用符号表单。
        // 	•	FontFeature.numerators(): 使用分子样式。
        // 	•	FontFeature.ordinalForms(): 使用序数样式。
        // 	•	FontFeature.proportionalFigures(): 使用比例数字。
        // 	•	FontFeature.scientificInferiors(): 使用科学下标样式。
        // 	•	FontFeature.slashedZero(): 使用带斜线的零。
        TextSpan(
          text: '$index',
          style: style.copyWith(
              fontFeatures: [
                FontFeature.oldstyleFigures(),
                FontFeature.scientificInferiors(),
              ],
              fontSize: style.fontSize == null ? null : style.fontSize! - 3,
              fontWeight: FontWeight.w900), // 调整行高以模拟偏移效果
        ),
        // WidgetSpan(
        //   child: Transform.translate(
        //     offset: Offset(0, 0),
        //     child: Text(
        //       '$index',
        //       style: style.copyWith(
        //           fontWeight: FontWeight.w900,
        //           textBaseline: TextBaseline.ideographic,
        //           fontSize:
        //               style.fontSize == null ? null : style.fontSize! - 3,
        //          ),
        //     ),
        //   ),
        // ),
        TextSpan(
            text: remain.substring(0, min(remain.length, 4)), style: style),
      ],
      style: style,
    );
  }

  String realValueStr = '-';
  if (value != null) {
    if (value >= 1000000000) {
      realValueStr = '${_dollarValue(value / 1000000000, 2)}B';
    } else if (value >= 1000000) {
      realValueStr = '${_dollarValue(value / 1000000, 2)}M';
    } else if (value >= 1000) {
      realValueStr = value.toStringAsFixed(2);
    } else {
      realValueStr = _dollarValue(value, 2);
    }
  }
  return TextSpan(text: realValueStr, style: style);
}