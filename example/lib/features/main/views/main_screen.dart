import 'package:example/core/consts/exports.dart';
import 'package:example/features/main/views/widgets/bottom_nav_widget.dart';
import 'package:example/core/framework/socket/socket_provider.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:web_socket_client/web_socket_client.dart' as socket;

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

final isFullScreen = ValueNotifier<bool>(false);

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Initialize currency after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CurrencyChanged>().init();
    });
  }

  List<PageRouteInfo> _getRoutes() {
    List<PageRouteInfo> routes = [
      SymbolsRoute(),
      ChartRoute(isFullscreen: isFullScreen),
      TradeRoute(),
      HistoryRoute(),
      const SettingsRoute(),
    ];
    return routes;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConnectCubit>();
    return Scaffold(
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: !context.isGestureNavigation,
        child: SocketProvider(
          noAccounts: false,
          noLoading: !cubit.socketState.value.isDisconnected,
          child: AutoTabsRouter(
            routes: _getRoutes(),
            transitionBuilder: (context, child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            builder: (context, child) {
              final tabsRouter = AutoTabsRouter.of(context);
              return ValueListenableBuilder(
                valueListenable: isFullScreen,
                builder: (context, isFullScreen, widget) {
                  if (context.isTablet) {
                    return Column(
                      children: [
                        Expanded(child: child),
                        if (!isFullScreen)
                          SizedBox(
                            height: 100.0,
                            child: bottomBarWidget(tabsRouter),
                          ),
                      ],
                    );
                  }
                  return Stack(
                    children: [
                      child,
                      if (!isFullScreen && !context.isLandscape)
                        bottomBarWidget(tabsRouter),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget bottomBarWidget(TabsRouter tabsRouter) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 8.0,
      child: BottomNavWidget(
        index: tabsRouter.activeIndex,
        onChanged: (value) {
          tabsRouter.setActiveIndex(value);
        },
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
    );
  }
}
