import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/socket_provider.dart';
import 'package:example/features/chart/views/chart_screen.dart';
import 'package:example/features/main/logic/bottom_nav_cubit.dart';
import 'package:example/features/settings/views/settings_screen.dart';
import 'package:example/features/symbols/views/quotes_screen.dart';
import 'package:example/features/trade/views/trade_screen.dart';
import 'package:example/features/trade_history/views/history_screen.dart';
import 'package:example/injection/injectable.dart';

import 'widgets/bottom_nav_widget.dart';

class MainScreen extends StatefulWidget {
  final int pageIndex;
  static const id = 'MainScreen';

  const MainScreen({super.key, this.pageIndex = 0});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final cubit = getIt<BottomNavCubit>();
  late final controller = TabController(
    length: 5,
    vsync: this,
    initialIndex: widget.pageIndex,
  );

  bool isFullSize = false;

  void navToChart() {
    controller.animateTo(1);
    cubit.moveTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        body: SafeArea(
          left: false,
          right: false,
          bottom: !context.isGestureNavigation,
          child: SocketProvider(
            child: Stack(
              children: [
                SafeArea(
                  child: TabBarView(
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const QuotesScreen(),
                      ChartScreen(
                        bottomNavController: controller,
                        onFullSize: (isOpened) {
                          isFullSize = isOpened;
                          setState(() {});
                        },
                      ),
                      const TradeScreen(),
                      const HistoryScreen(),
                      const SettingsScreen(),
                    ],
                  ),
                ),
                if (!isFullSize)
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: BottomNavWidget(
                      onChanged: (value) => controller.animateTo(value),
                      items: [
                        NavModel(
                          key: 'Quotes',
                          icon: Svgs.quotes,
                          name: context.tr.quotes,
                        ),
                        NavModel(
                          key: 'Chart',
                          icon: Svgs.chart,
                          name: context.tr.chart,
                        ),
                        NavModel(
                          key: 'Trade',
                          icon: Svgs.trade,
                          name: context.tr.trade,
                        ),
                        NavModel(
                          key: 'History',
                          icon: Svgs.history,
                          name: context.tr.history,
                        ),
                        NavModel(
                          key: 'Settings',
                          icon: Svgs.settings,
                          name: context.tr.settings,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
