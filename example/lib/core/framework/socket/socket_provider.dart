import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/trade/logic/close_position_cubit.dart';
import 'package:example/features/trade/logic/modify_order_cubit.dart';
import 'package:example/features/trade/logic/modify_position_cubit.dart';
import 'package:example/features/trade/logic/open_position_cubit.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade_history/logic/history_actions_cubit.dart';
import 'package:example/features/trade_history/logic/history_pending_cubit.dart';
import 'package:example/features/trade_history/logic/history_positions_cubit.dart';
import 'package:example/injection/injectable.dart';

class SocketProvider extends StatefulWidget {
  final Widget child;
  final bool noAccounts;
  final bool noLoading;

  const SocketProvider({
    super.key,
    required this.child,
    required this.noAccounts,
    this.noLoading = false,
  });

  @override
  State<SocketProvider> createState() => _SocketProviderState();
}

class _SocketProviderState extends State<SocketProvider> {
  final connectionChecker = getIt<InternetConnection>();
  late final _loginCubit = context.read<ConnectCubit>();
  late final StreamSubscription _subscription;
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    if (widget.noAccounts) return;
    if (widget.noLoading) {
      Future.wait([
        context.read<QuotesCubit>().getCachedSymbols(),
        context.read<PositionsCubit>().getInfo(),
        context.read<PositionsCubit>().getCachedPositions(),
        context.read<OrdersCubit>().getCachedOrders(),
        context.read<HistoryPositionsCubit>().getCachedPositions(),
        context.read<HistoryActionsCubit>().getCachedActions(),
        context.read<HistoryPendingCubit>().getCachedPositions(),
      ]);
    }
    _listener = AppLifecycleListener(
      onResume: () {
        _loginCubit.directConnect(
          openLocalDatabase: false,
          onConnected: () {
            context.read<ChartCubit>().init();
            context.read<QuotesCubit>().init(noLoading: widget.noLoading);
            context.read<QuotesCubit>().sendToSubscribe();
            context.read<PositionsCubit>().init();
            context.read<OrdersCubit>().init();
            context.read<OpenPositionCubit>().init();
            context.read<ModifyPositionCubit>().init();
            context.read<ClosePositionCubit>().init();
            context.read<ModifyOrderCubit>().init();
            context.read<HistoryPositionsCubit>().init();
            context.read<HistoryPendingCubit>().init();
            context.read<HistoryActionsCubit>().init();
            context.read<HistoryPositionsCubit>().getAll();
            context.read<HistoryActionsCubit>().getAll();
            context.read<HistoryPendingCubit>().getAll();
          },
        );
      },
      onInactive: () {
        _loginCubit.closeSocket();
      },
    );
    _subscription = connectionChecker.onStatusChange.listen((event) {
      if (event == InternetStatus.connected) {
        _loginCubit.directConnect(
          onConnected: () {
            context.read<ChartCubit>().init();
            context.read<QuotesCubit>().init(noLoading: widget.noLoading);
            context.read<QuotesCubit>().sendToSubscribe();
            context.read<PositionsCubit>().init();
            context.read<OrdersCubit>().init();
            context.read<OpenPositionCubit>().init();
            context.read<ModifyPositionCubit>().init();
            context.read<ClosePositionCubit>().init();
            context.read<ModifyOrderCubit>().init();
            context.read<HistoryPositionsCubit>().init();
            context.read<HistoryActionsCubit>().init();
            context.read<HistoryPendingCubit>().init();
            context.read<HistoryPositionsCubit>().getAll();
            context.read<HistoryActionsCubit>().getAll();
            context.read<HistoryPendingCubit>().getAll();
          },
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _loginCubit.dispose();
    _listener.dispose();
    _subscription.cancel();
    super.dispose();
  }
}
