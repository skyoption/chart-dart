import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/pick_option.dart';
import 'package:example/core/widgets/custom_drop_down.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/settings/views/widgets/platform_switch_item.dart';
import 'package:example/features/settings/views/widgets/trading_color_picker_widget.dart';

class TradingSettingsScreen extends StatefulWidget {
  static const id = 'TradingSettingsScreen';

  const TradingSettingsScreen({super.key});

  @override
  State<TradingSettingsScreen> createState() => _TradingSettingsScreenState();
}

class _TradingSettingsScreenState extends State<TradingSettingsScreen> {
  late final PlatformSettingsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<PlatformSettingsCubit>();
  }

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
                color: context.colorScheme.scrim,
                size: 32.0,
              ).addAction(
                padding: const MPadding.set(vertical: 21.0, end: 12.0),
                onGesture: () => context.pop(),
              ),
              MText(
                text: context.tr.tradingSettings,
                color: context.colorScheme.scrim,
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
                  title: context.tr.tradeNotification,
                  subtitle: context.tr.tradeNotificationSubtitle,
                  initialValue: cubit.settings.tradeNotification,
                  onChanged: cubit.toggleTradeNotification,
                ),
                PlatformSwitchItem(
                  title: context.tr.tradeNotificationSound,
                  subtitle: context.tr.tradeNotificationSoundSubtitle,
                  initialValue: cubit.settings.tradeNotificationSound,
                  onChanged: cubit.toggleTradeNotificationSound,
                ),
                PlatformSwitchItem(
                  title: context.tr.tradeNotificationVibration,
                  subtitle: context.tr.tradeNotificationVibrationSubtitle,
                  initialValue: cubit.settings.tradeNotificationVibration,
                  onChanged: cubit.toggleNotificationVibration,
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
