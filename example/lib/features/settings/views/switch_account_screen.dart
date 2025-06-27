import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/auth/views/login_screen.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/main/views/widgets/trading_account_item_widget.dart';
import 'package:example/features/settings/logic/accounts_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade_history/logic/history_actions_cubit.dart';
import 'package:example/features/trade_history/logic/history_pending_cubit.dart';
import 'package:example/features/trade_history/logic/history_positions_cubit.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/main.dart';

class SwitchAccountScreen extends StatefulWidget {
  static const id = 'SwitchAccountScreen';

  const SwitchAccountScreen({super.key});

  @override
  State<SwitchAccountScreen> createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  late final AccountsCubit accountsCubit = getIt<AccountsCubit>();
  late final ConnectCubit loginCubit = context.read<ConnectCubit>();

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return BlocProvider(
      create: (context) => accountsCubit..execute(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(width, height * 0.07),
          child: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: context.colorScheme.scrim,
                        size: 30.0,
                      ).addAction(
                        padding: const MPadding.set(end: 12.0),
                        onGesture: () {
                          context.pop();
                        },
                      ),
                      MText(
                        text: context.tr.switchAccount,
                        size: FoontSize.font18,
                        color: context.colorScheme.scrim,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: MSvg(
                    name: Svgs.addAccountIcon,
                    color: context.colorScheme.scrim,
                    width: 21.0,
                    height: 21.0,
                  ).addAction(
                    padding: const MPadding.set(end: 12.0),
                    onGesture: () {
                      context.push(
                        LoginScreen(
                          onAddNewAccount: (number, password) {
                            Future.delayed(
                              const Duration(milliseconds: 650),
                              () {
                                onSwitch(
                                  number: number,
                                  password: password,
                                  loginCubit: loginCubit,
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ).addPadding(vertical: 12.0, horizontal: 21.0),
          ),
        ),
        body: MScroll(
          padding: const MPadding.set(bottom: 30.0),
          child: FlowBuilder<AccountsCubit>(
            builder: (context, state, cubit) {
              return FlowBuilder<ConnectCubit>(
                builder: (context, state, loginCubit) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      cubit.accounts.length,
                      (index) {
                        if (index == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TradingAccountItemWidget(
                                onDelete: () {},
                                onSwitch: () {},
                                accountInfo: cubit.accounts[index],
                              ).addPadding(bottom: 15),
                              if (cubit.accounts.length != 1)
                                const Divider().addPadding(bottom: 15),
                              if (cubit.accounts.length != 1)
                                MText(
                                  text: context.tr.switchAccount,
                                  size: FoontSize.font18,
                                  color: context.colorScheme.onSurface,
                                  weight: FontWeight.w600,
                                ).addPadding(horizontal: 21.0, bottom: 15),
                            ],
                          );
                        } else {
                          return TradingAccountItemWidget(
                            accountInfo: cubit.accounts[index],
                            onDelete: () {
                              loginCubit.deleteAccount(
                                id: cubit.accounts[index].id,
                                onDeleted: cubit.execute,
                              );
                            },
                            onSwitch: () {
                              loginCubit.switchAccount(
                                id: cubit.accounts[index].id,
                                onSwitch: (credential) {
                                  cubit.execute();
                                  onSwitch(
                                    number: credential.id,
                                    password: credential.password,
                                    loginCubit: loginCubit,
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void onSwitch({
    required dynamic number,
    required String password,
    required ConnectCubit loginCubit,
  }) {
    final symbols = rootContext.context.read<PositionsCubit>().symbols;
    loginCubit.connect(
      isLogin: true,
      showError: false,
      number: number.toString(),
      password: password,
      refresh: () {
        accountsCubit.execute();
      },
      onConnected: () {
        rootContext.context.read<ChartCubit>().init();
        rootContext.context.read<QuotesCubit>().getCachedSymbols();
        rootContext.context.read<PositionsCubit>().getCachedPositions();
        rootContext.context.read<OrdersCubit>().getCachedOrders();
        rootContext.context.read<HistoryPositionsCubit>().getCachedPositions();
        rootContext.context.read<HistoryActionsCubit>().getCachedActions();
        rootContext.context.read<HistoryPendingCubit>().getCachedPositions();
        rootContext.context.read<QuotesCubit>().init();
        rootContext.context.read<QuotesCubit>().sendToSubscribe();
        rootContext.context.read<QuotesCubit>().onSwitchAccount(symbols);
        rootContext.context.read<PositionsCubit>().getInfo();
        rootContext.context.read<PositionsCubit>().init();
        rootContext.context.read<OrdersCubit>().init();
        rootContext.context.read<HistoryPendingCubit>().init();
        rootContext.context.read<HistoryPositionsCubit>().init();
        rootContext.context.read<HistoryActionsCubit>().init();
        rootContext.context.read<HistoryPositionsCubit>().getAll();
        rootContext.context.read<HistoryActionsCubit>().getAll();
        rootContext.context.read<HistoryPendingCubit>().getAll();
      },
    );
  }
}
