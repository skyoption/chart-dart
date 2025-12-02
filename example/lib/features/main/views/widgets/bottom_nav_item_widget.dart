import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/jsons.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:web_socket_client/web_socket_client.dart' as socket;

class BottomNavItemWidget extends StatelessWidget {
  final bool active;
  final String icon;
  final String title;
  final int mKey;

  const BottomNavItemWidget({
    super.key,
    required this.active,
    required this.icon,
    required this.title,
    required this.mKey,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        active ? context.colorScheme.onPrimary : context.colorScheme.onSurface;
    if (active) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: MBorderRadius.set(all: 14.0),
          color: context.colorScheme.primary,
        ),
        padding: const MPadding.set(
          vertical: 12.0,
          horizontal: 7.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (mKey == 4)
              ValueListenableBuilder<socket.ConnectionState?>(
                valueListenable:
                    context.read<ConnectCubit>().loginDataSource.socket.state,
                builder: (context, value, child) {
                  if (value is socket.Connected ||
                      value is socket.Reconnected) {
                    return MSvg(
                      name: icon,
                      color: color,
                      height: 24.0,
                    );
                  }
                  return const MLottieImage(
                    name: Jsons.reconnect,
                    height: 24.0,
                    width: 24.0,
                  );
                },
              ).addPadding(end: 6.0)
            else
              MSvg(
                name: icon,
                color: color,
                height: 24.0,
              ).addPadding(end: 6.0),
            MText(
              text: title,
              size: FoontSize.font14,
              color: color,
              weight: FontWeight.w400,
            )
          ],
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (mKey == 4)
          ValueListenableBuilder<socket.ConnectionState?>(
            valueListenable:
                context.read<ConnectCubit>().loginDataSource.socket.state,
            builder: (context, value, child) {
              if (value is socket.Connected || value is socket.Reconnected) {
                return MSvg(
                  name: icon,
                  color: color,
                  height: 24.0,
                ).addPadding(bottom: 6.0);
              }
              return const MLottieImage(
                name: Jsons.reconnect,
                height: 30.0,
                width: 30.0,
              );
            },
          )
        else
          MSvg(
            name: icon,
            color: color,
            height: 24.0,
          ).addPadding(bottom: 6.0),
        MText(
          text: title,
          size: FoontSize.font14,
          color: color,
          weight: FontWeight.w400,
        )
      ],
    );
  }
}
