import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/utils/kprint.dart';

import '../k_chart_widget.dart';

/// Base Dimension
class BaseDimension {
  // the height of base chart
  double _mBaseHeight = 380;

  // default: 0
  // the height of volume chart
  double _mVolumeHeight = 0;

  // default: 0
  // the height of a secondary chart
  double _mSecondaryHeight = 0;

  // total height of chart: _mBaseHeight + _mVolumeHeight + (_mSecondaryHeight * n)
  // n : number of secondary charts
  //
  double _mDisplayHeight = 0;

  // getter the vol height
  double get mVolumeHeight => _mVolumeHeight;

  // getter the secondary height
  double get mSecondaryHeight => _mSecondaryHeight;

  // getter the total height
  double get mDisplayHeight => _mDisplayHeight;

  set mDisplayHeight(double value) => _mDisplayHeight = value;

  // getter the total height
  double get mBaseHeight => _mBaseHeight;

  set mBaseHeight(double value) => mBaseHeight = value;

  /// constructor
  ///
  /// BaseDimension
  /// set _mBaseHeight
  /// compute value of _mVolumeHeight, _mSecondaryHeight, _mDisplayHeight
  BaseDimension({
    required double mBaseHeight,
    required bool volHidden,
    required List<IndicatorEntity> indicators,
  }) {
    _mBaseHeight = mBaseHeight;
    _mVolumeHeight = volHidden != true ? _mBaseHeight * 0.2 : 0;
    _mSecondaryHeight =
        _setSecondaryHeight(indicators, mBaseHeight * 0.7) + _mVolumeHeight;
    _mDisplayHeight = _mBaseHeight + mBaseHeight * 0.25;
  }

  double _setSecondaryHeight(
    List<IndicatorEntity> indicators,
    double _mBaseHeight,
  ) {
    double _mSecondaryHeight = 0;
    for (var item in indicators) {
      _mSecondaryHeight += getSecondaryHeight(item);
    }
    return _mSecondaryHeight;
  }

  double getSecondaryHeight(IndicatorEntity item) {
    if (item.type == IndicatorType.MACD) {
      return _mBaseHeight * 0.2;
    } else if (item.type == IndicatorType.RSI) {
      return _mBaseHeight * 0.25;
    }
    return 0.0;
  }
}
