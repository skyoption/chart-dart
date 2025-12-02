import 'package:example/app.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:example/core/shared/guide_tooltip_widget.dart';

// Enums with config extensions for each screen
enum QuotesTooltip {
  editSymbols,
  layoutToggle,
  addSymbol,
  sortSymbols,
  symbolList,
}

enum ChartTooltip {
  chartOptions,
  symbolSelection,
  fullscreenToggle,
  zoomOptions,
  screenRotation,
  timeframeSelection,
  tradingPanel,
}

enum TradeTooltip {
  floatingPnL,
  sortFilter,
  newPosition,
  positionsTab,
  pendingTab,
  moreActions,
  tradeInfo,
}

enum HistoryTooltip {
  sortHistory,
  filterHistory,
  tabSwitcher,
  historyInfo,
}

enum SettingsTooltip {
  tradingAccount,
  switchAccount,
  addAccount,
  changePassword,
  changeTheme,
  language,
  tradingSettings,
  logs,
  tickets,
  logout,
}

// Extensions to return configs directly
extension QuotesTooltipExtension on QuotesTooltip {
  GuideToolTipConfig get config {
    switch (this) {
      case QuotesTooltip.editSymbols:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipEditSymbols,
          description: SkyTrading.tr.tooltipEditSymbolsDescription,
          displayIndex: 0,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case QuotesTooltip.layoutToggle:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipLayoutToggle,
          description: SkyTrading.tr.tooltipLayoutToggleDescription,
          displayIndex: 1,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case QuotesTooltip.addSymbol:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipAddSymbol,
          description: SkyTrading.tr.tooltipAddSymbolDescription,
          displayIndex: 2,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case QuotesTooltip.sortSymbols:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipSortSymbols,
          description: SkyTrading.tr.tooltipSortSymbolsDescription,
          displayIndex: 3,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case QuotesTooltip.symbolList:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipSymbolList,
          description: SkyTrading.tr.tooltipSymbolListDescription,
          displayIndex: 4,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
    }
  }
}

extension ChartTooltipExtension on ChartTooltip {
  GuideToolTipConfig get config {
    switch (this) {
      case ChartTooltip.chartOptions:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipChartOptions,
          description: SkyTrading.tr.tooltipChartOptionsDescription,
          displayIndex: 0,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case ChartTooltip.symbolSelection:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipSymbolSelection,
          description: SkyTrading.tr.tooltipSymbolSelectionDescription,
          displayIndex: 1,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case ChartTooltip.fullscreenToggle:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipFullscreenToggle,
          description: SkyTrading.tr.tooltipFullscreenToggleDescription,
          displayIndex: 2,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case ChartTooltip.zoomOptions:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipZoomOptions,
          description: SkyTrading.tr.tooltipZoomOptionsDescription,
          displayIndex: 3,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case ChartTooltip.screenRotation:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipScreenRotation,
          description: SkyTrading.tr.tooltipScreenRotationDescription,
          displayIndex: 4,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case ChartTooltip.timeframeSelection:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipTimeframeSelection,
          description: SkyTrading.tr.tooltipTimeframeSelectionDescription,
          displayIndex: 5,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case ChartTooltip.tradingPanel:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipTradingPanel,
          description: SkyTrading.tr.tooltipTradingPanelDescription,
          displayIndex: 6,
          verticalPosition: TooltipVerticalPosition.TOP,
        );
    }
  }
}

extension TradeTooltipExtension on TradeTooltip {
  GuideToolTipConfig get config {
    switch (this) {
      case TradeTooltip.floatingPnL:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipFloatingPnL,
          description: SkyTrading.tr.tooltipFloatingPnLDescription,
          displayIndex: 0,
        );
      case TradeTooltip.sortFilter:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipSortFilter,
          description: SkyTrading.tr.tooltipSortFilterDescription,
          displayIndex: 1,
        );
      case TradeTooltip.newPosition:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipNewPosition,
          description: SkyTrading.tr.tooltipNewPositionDescription,
          displayIndex: 2,
        );
      case TradeTooltip.tradeInfo:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipTradeInfo,
          description: SkyTrading.tr.tooltipTradeInfoDescription,
          displayIndex: 3,
        );

      case TradeTooltip.positionsTab:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipPositionsTab,
          description: SkyTrading.tr.tooltipPositionsTabDescription,
          displayIndex: 4,
        );
      case TradeTooltip.pendingTab:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipPendingTab,
          description: SkyTrading.tr.tooltipPendingTabDescription,
          displayIndex: 5,
        );
      case TradeTooltip.moreActions:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipMoreActions,
          description: SkyTrading.tr.tooltipMoreActionsDescription,
          displayIndex: 6,
        );
    }
  }
}

extension HistoryTooltipExtension on HistoryTooltip {
  GuideToolTipConfig get config {
    switch (this) {
      case HistoryTooltip.sortHistory:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipSortHistory,
          description: SkyTrading.tr.tooltipSortHistoryDescription,
          displayIndex: 0,
        );
      case HistoryTooltip.filterHistory:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipFilterHistory,
          description: SkyTrading.tr.tooltipFilterHistoryDescription,
          displayIndex: 1,
        );
      case HistoryTooltip.tabSwitcher:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipTabSwitcher,
          description: SkyTrading.tr.tooltipTabSwitcherDescription,
          displayIndex: 2,
        );
      case HistoryTooltip.historyInfo:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipHistoryInfo,
          description: SkyTrading.tr.tooltipHistoryInfoDescription,
          displayIndex: 3,
        );
    }
  }
}

extension SettingsTooltipExtension on SettingsTooltip {
  GuideToolTipConfig get config {
    switch (this) {
      case SettingsTooltip.tradingAccount:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipTradingAccount,
          description: SkyTrading.tr.tooltipTradingAccountDescription,
          displayIndex: 0,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case SettingsTooltip.switchAccount:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipSwitchAccount,
          description: SkyTrading.tr.tooltipSwitchAccountDescription,
          displayIndex: 1,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case SettingsTooltip.addAccount:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipAddAccount,
          description: SkyTrading.tr.tooltipAddAccountDescription,
          displayIndex: 2,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case SettingsTooltip.changePassword:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipChangePassword,
          description: SkyTrading.tr.tooltipChangePasswordDescription,
          displayIndex: 3,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case SettingsTooltip.changeTheme:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipChangeTheme,
          description: SkyTrading.tr.tooltipChangeThemeDescription,
          displayIndex: 4,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case SettingsTooltip.language:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipLanguage,
          description: SkyTrading.tr.tooltipLanguageDescription,
          displayIndex: 5,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case SettingsTooltip.tradingSettings:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipTradingSettings,
          description: SkyTrading.tr.tooltipTradingSettingsDescription,
          displayIndex: 6,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case SettingsTooltip.logs:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipLogs,
          description: SkyTrading.tr.tooltipLogsDescription,
          displayIndex: 7,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case SettingsTooltip.tickets:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipTickets,
          description: SkyTrading.tr.tooltipTicketsDescription,
          displayIndex: 8,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
      case SettingsTooltip.logout:
        return GuideToolTipConfig(
          title: SkyTrading.tr.tooltipLogout,
          description: SkyTrading.tr.tooltipLogoutDescription,
          displayIndex: 9,
          verticalPosition: TooltipVerticalPosition.BOTTOM,
        );
    }
  }
}
