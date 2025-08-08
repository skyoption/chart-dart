import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';

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

  double _mSecondaryRetro = 0.4;

  // getter the vol height
  double get mVolumeHeight => _mVolumeHeight;

  // getter the secondary height
  double get mSecondaryHeight => _mSecondaryHeight;

  double get mSecondaryRetro => _mSecondaryRetro;

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
    required double height,
    required bool volHidden,
    required Map<int, List<IndicatorEntity>> indicators,
    required double secondaryRetro,
    required bool hideIndicators,
  }) {
    if (hideIndicators) {
      _mDisplayHeight = height;
    } else {
      List<IndicatorEntity> items = [];
      for (var i = 0; i < indicators.length; i++) {
        items.add(HighLevelIndicator.getHigh(indicators, i));
      }
      _mSecondaryRetro = secondaryRetro;
      _mVolumeHeight = volHidden != true ? _mBaseHeight * 0.2 : 0;
      _mSecondaryHeight = _setSecondaryHeight(items, height);
      _mDisplayHeight = height;
    }
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

  double getSecondaryHeight(IndicatorEntity? item) {
    return _mBaseHeight * mSecondaryRetro;
  }
}
