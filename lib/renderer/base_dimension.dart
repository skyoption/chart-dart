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
    return _mBaseHeight * item!.heightRetro;
  }

  /// Rearrange rects by updating heightRetro values
  /// This function redistributes the height among indicators
  ///
  /// @param deltaHeight: Positive value increases the target indicator height,
  ///                     Negative value decreases the target indicator height
  void rearrangeRects(
    Map<int, List<IndicatorEntity>> indicators,
    int targetRectIndex,
    double deltaHeight,
  ) {
    List<IndicatorEntity> allIndicators = [];
    for (var i = 0; i < indicators.length; i++) {
      allIndicators.addAll(indicators[i] ?? []);
    }

    if (targetRectIndex >= allIndicators.length) return;

    final targetIndicator = allIndicators[targetRectIndex];
    final currentHeightRetro = targetIndicator.heightRetro;

    // Calculate new heightRetro for target indicator
    // deltaHeight is positive when we want to increase the indicator height
    // deltaHeight is negative when we want to decrease the indicator height
    final heightChange = deltaHeight / _mBaseHeight;
    final newHeightRetro = (currentHeightRetro + heightChange).clamp(0.1, 0.8);

    // Update target indicator
    targetIndicator.heightRetro = newHeightRetro;

    // For cases with 2 or 3 indicators, redistribute the remaining height proportionally
    if (allIndicators.length >= 2) {
      _redistributeRemainingHeight(allIndicators, targetRectIndex);
    }

    // Recalculate total secondary height
    _mSecondaryHeight = _setSecondaryHeight(allIndicators, _mBaseHeight);
  }

  /// Redistribute remaining height among other indicators
  void _redistributeRemainingHeight(
      List<IndicatorEntity> allIndicators, int targetIndex) {
    // Calculate total height used by target indicator
    final targetHeight = allIndicators[targetIndex].heightRetro;

    // Calculate remaining height for other indicators
    final remainingHeight = 1.0 - targetHeight;

    // Get other indicators (excluding target)
    final otherIndicators = <IndicatorEntity>[];
    for (int i = 0; i < allIndicators.length; i++) {
      if (i != targetIndex) {
        otherIndicators.add(allIndicators[i]);
      }
    }

    if (otherIndicators.isEmpty) return;

    // Distribute remaining height proportionally among other indicators
    final totalOtherHeight = otherIndicators.fold<double>(
        0.0, (sum, indicator) => sum + indicator.heightRetro);

    if (totalOtherHeight > 0) {
      final scaleFactor = remainingHeight / totalOtherHeight;
      for (final indicator in otherIndicators) {
        indicator.heightRetro =
            (indicator.heightRetro * scaleFactor).clamp(0.1, 0.8);
      }
    } else {
      // If no height was allocated to others, distribute equally
      final equalHeight = remainingHeight / otherIndicators.length;
      for (final indicator in otherIndicators) {
        indicator.heightRetro = equalHeight.clamp(0.1, 0.8);
      }
    }
  }

  /// Get all indicators as a flat list
  List<IndicatorEntity> getAllIndicators(
      Map<int, List<IndicatorEntity>> indicators) {
    List<IndicatorEntity> allIndicators = [];
    for (var i = 0; i < indicators.length; i++) {
      allIndicators.addAll(indicators[i] ?? []);
    }
    return allIndicators;
  }
}
