import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/custom_drop_down.dart';
import 'package:example/features/settings/views/widgets/platform_switch_item.dart';
import 'package:example/features/settings/views/widgets/trading_color_picker_widget.dart';
import 'package:example/core/consts/pick_option.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';

@RoutePage()
class TradingSettingsScreen extends StatelessWidget {
  const TradingSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.08),
        child: SafeArea(
          child: Row(
            children: [
              Icon(
                Icons.arrow_back,
                color: context.colorScheme.onSurface,
                size: 32.0,
              ).addAction(
                padding: const MPadding.set(vertical: 21.0, end: 12.0),
                onGesture: () => AutoRouterX(context).pop(),
              ),
              MText(
                text: context.tr.tradingSettings,
                color: context.colorScheme.onSurface,
                weight: FontWeight.w600,
                size: FoontSize.font18,
              ),
            ],
          ).addPadding(horizontal: 21.0),
        ),
      ),
      body: MScroll(
        padding: const MPadding.set(horizontal: 21.0),
        child: FlowBuilder<PlatformSettingsCubit>(
          builder: (context, state, cubit) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlatformSwitchItem(
                  title: context.tr.tradePositionNotification,
                  subtitle: context.tr.tradePositionNotificationSubtitle,
                  initialValue: cubit.settings.tradePositionNotification,
                  onChanged: cubit.toggleTradePositionNotification,
                ),
                PlatformSwitchItem(
                  title: context.tr.tradePositionNotificationSound,
                  subtitle: context.tr.tradePositionNotificationSoundSubtitle,
                  initialValue: cubit.settings.tradePositionNotificationSound,
                  onChanged: cubit.toggleTradePositionNotificationSound,
                ),
                PlatformSwitchItem(
                  title: context.tr.tradePositionNotificationVibration,
                  subtitle:
                      context.tr.tradePositionNotificationVibrationSubtitle,
                  initialValue:
                      cubit.settings.tradePositionNotificationVibration,
                  onChanged: cubit.togglePositionNotificationVibration,
                ),
                PlatformSwitchItem(
                  title: context.tr.tradeOrderNotification,
                  subtitle: context.tr.tradeOrderNotificationSubtitle,
                  initialValue: cubit.settings.tradePositionNotification,
                  onChanged: cubit.toggleTradeOrderNotification,
                ),
                PlatformSwitchItem(
                  title: context.tr.tradeOrderNotificationSound,
                  subtitle: context.tr.tradeOrderNotificationSoundSubtitle,
                  initialValue: cubit.settings.tradePositionNotificationSound,
                  onChanged: cubit.toggleTradeOrderNotificationSound,
                ),
                PlatformSwitchItem(
                  title: context.tr.tradeOrderNotificationVibration,
                  subtitle: context.tr.tradeOrderNotificationVibrationSubtitle,
                  initialValue:
                      cubit.settings.tradePositionNotificationVibration,
                  onChanged: cubit.toggleTradeOrderNotificationVibration,
                ),
                PlatformSwitchItem(
                  title: context.tr.showAskLine,
                  subtitle: context.tr.showAskLineOnChart,
                  initialValue: cubit.settings.showAskLine,
                  onChanged: cubit.toggleShowAskLine,
                ).addPadding(bottom: 8.0),
                TradingColorPickerWidget(
                  title: context.tr.chartLine,
                  lightDefaultColor:
                      Color(cubit.settings.chartThemeLightColorValue),
                  darkDefaultColor:
                      Color(cubit.settings.chartThemeDarkColorValue),
                  onLightColorChange: cubit.updateChartThemeLightColor,
                  onDarkColorChanged: cubit.updateChartThemeDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.areaColor,
                  lightDefaultColor: Color(cubit.settings.areaLightColorValue),
                  darkDefaultColor: Color(cubit.settings.areaLightColorValue),
                  onLightColorChange: cubit.updateAreaLightColor,
                  onDarkColorChanged: cubit.updateAreaDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.chartGridColor,
                  lightDefaultColor:
                      Color(cubit.settings.chartGridLightColorValue),
                  darkDefaultColor:
                      Color(cubit.settings.chartGridDarkColorValue),
                  onLightColorChange: cubit.updateChartGridLightColor,
                  onDarkColorChanged: cubit.updateChartGridDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.cursorColor,
                  lightDefaultColor: Color(
                    cubit.settings.cursorLightColorValue,
                  ),
                  darkDefaultColor: Color(cubit.settings.cursorDarkColorValue),
                  onLightColorChange: cubit.updateCursorLightColor,
                  onDarkColorChanged: cubit.updateCursorDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.candleUpColor,
                  lightDefaultColor: Color(
                    cubit.settings.candleUpLightColorValue,
                  ),
                  darkDefaultColor: Color(
                    cubit.settings.candleUpDarkColorValue,
                  ),
                  onLightColorChange: cubit.updateCandleUpLightColor,
                  onDarkColorChanged: cubit.updateCandleUpDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.candleDownColor,
                  lightDefaultColor: Color(
                    cubit.settings.candleDownLightColorValue,
                  ),
                  darkDefaultColor: Color(
                    cubit.settings.candleDownDarkColorValue,
                  ),
                  onLightColorChange: cubit.updateCandleDownLightColor,
                  onDarkColorChanged: cubit.updateCandleDownDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.ask,
                  lightDefaultColor: Color(cubit.settings.askLightColorValue),
                  darkDefaultColor: Color(cubit.settings.askDarkColorValue),
                  onLightColorChange: cubit.updateAskLightColor,
                  onDarkColorChanged: cubit.updateAskDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.bid,
                  lightDefaultColor: Color(cubit.settings.bidLightColorValue),
                  darkDefaultColor: Color(cubit.settings.bidDarkColorValue),
                  onLightColorChange: cubit.updateBidLightColor,
                  onDarkColorChanged: cubit.updateBidDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.stopLossTitle,
                  lightDefaultColor:
                      Color(cubit.settings.stopLossLightColorValue),
                  darkDefaultColor:
                      Color(cubit.settings.stopLossDarkColorValue),
                  onLightColorChange: cubit.updateStopLossLightColor,
                  onDarkColorChanged: cubit.updateStopLossDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.takeProfitTitle,
                  lightDefaultColor:
                      Color(cubit.settings.takeProfitLightColorValue),
                  darkDefaultColor:
                      Color(cubit.settings.takeProfitDarkColorValue),
                  onLightColorChange: cubit.updateTakeProfitLightColor,
                  onDarkColorChanged: cubit.updateTakeProfitDarkColor,
                ),
                TradingColorPickerWidget(
                  title: context.tr.trade,
                  lightDefaultColor: Color(cubit.settings.tradeLightColorValue),
                  darkDefaultColor: Color(cubit.settings.tradeDarkColorValue),
                  onLightColorChange: cubit.updateTradeLightColor,
                  onDarkColorChanged: cubit.updateTradeDarkColor,
                ),
                CDropDown<double>(
                  title: context.tr.chartLineSize,
                  options: chartLineSizes,
                  initialValue: cubit.settings.chartLineSize,
                  onSelection: cubit.onChartLineSizeChange,
                ).addPadding(bottom: 12.0)
              ],
            );
          },
        ),
      ),
    );
  }
}
