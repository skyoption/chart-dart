import 'package:example/core/consts/exports.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';

@RoutePage()
class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

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
                size: 30.0,
              ).addAction(
                padding: const MPadding.set(end: 16.0),
                onGesture: () => AutoRouterX(context).pop(),
              ),
              MText(
                text: context.tr.logs,
                color: context.colorScheme.onSurface,
                weight: FontWeight.w600,
                size: FoontSize.font18,
              ),
            ],
          ).addPadding(horizontal: 21.0),
        ),
      ),
      body: FlowBuilder<TradingLogsCubit>(
        builder: (context, state, cubit) {
          return ListView.separated(
            itemCount: cubit.logs.length,
            padding: const MPadding.set(vertical: 25.0, horizontal: 16),
            separatorBuilder: (context, index) {
              return MDividerItemWidget(
                color: context.colorScheme.outline,
                padding: const MPadding.set(vertical: 18.0),
              );
            },
            itemBuilder: (context, index) {
              final log = cubit.logs[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MText(
                        text: "'${log.accountNumber}' : ",
                        color: context.colorScheme.onSurface,
                        size: FoontSize.font16,
                        weight: FontWeight.w400,
                      ),
                      Flexible(
                        child: MText(
                          text: log.event,
                          color: context.colorScheme.onSurface,
                          size: FoontSize.font16,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ).addPadding(bottom: 2.0),
                  MText(
                    text: log.createdAt.toIso8601String().toLastTime,
                    color: context.colorScheme.onSurface,
                    size: FoontSize.font14,
                    weight: FontWeight.w300,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
