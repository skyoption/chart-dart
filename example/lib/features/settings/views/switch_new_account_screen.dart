import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/loading.dart';
import 'package:example/features/auth/views/logic/get_socket_servers_cubit.dart';
import 'package:example/features/trade/views/widgets/trade_dropdown_item_widget.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/auth/domain/entities/socket_server_entity.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/injection/injectable.dart';

@RoutePage()
class SwitchNewAccountScreen extends StatefulWidget {
  final Function(String user, String password, String serverUrl)?
      onAddNewAccount;

  const SwitchNewAccountScreen({
    super.key,
    this.onAddNewAccount,
  });

  @override
  State<SwitchNewAccountScreen> createState() => _SwitchNewAccountScreenState();
}

class _SwitchNewAccountScreenState extends State<SwitchNewAccountScreen> {
  late final cubit = context.read<ConnectCubit>();
  @override
  void initState() {
    cubit.number.text = "";
    cubit.password?.text = "";
    super.initState();
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
                color: context.colorScheme.onSurface,
                size: 32.0,
              ).addAction(
                padding: const MPadding.set(vertical: 21.0, end: 12.0),
                onGesture: () => AutoRouterX(context).pop(),
              ),
              MText(
                text: context.tr.switchAccount,
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
        child: Form(
          key: cubit.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MSvg(
                name: context.isDarkTheme ? Svgs.logoDark : Svgs.logo,
                width: 35.0,
                height: 35.0,
              ).addPadding(bottom: 30.0, top: 35.0),
              MText(
                text: context.tr.loginWelcomeMessage,
                size: FoontSize.font17,
                weight: FontWeight.w400,
                color: context.colorScheme.onSurface,
              ).addPadding(bottom: 30.0),
              FlowBuilder<GetSocketServersCubit>(
                onSuccess: (state, cubit) {
                  if (cubit.servers.isNotEmpty) {
                    getIt<Sockeet>().socketUrl = cubit.servers.first.url;
                  }
                },
                loading: Loading.loadingSkeleton(
                  padding: const MPadding.set(bottom: 12.0),
                  borderRadius: MBorderRadius.set(all: 8.0),
                  height: 55.0,
                  width: context.width,
                ),
                builder: (context, state, serversCubit) {
                  return TradeDropdownItemWidget<SocketServerEntity>(
                    height: 55.0,
                    width: context.width,
                    searchTitle: context.tr.searchByServerName,
                    options: serversCubit.servers,
                    isOutline: false,
                    onTap: (item) {
                      cubit.serverUrl = item.url;
                    },
                    onName: (item) => item.serverName,
                  );
                },
              ).addPadding(bottom: 6.0),
              MTextFiled(
                hintText: context.tr.accountNumber,
                hintColor: context.colorScheme.onSurface,
                controller: cubit.number,
                textColor: context.colorScheme.onSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: context.colorScheme.surfaceContainer,
                textSize: FoontSize.font18,
                hintSize: FoontSize.font16,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                ),
                contentPadding: MPadding.set(horizontal: 21.0, vertical: 14.0),
                validator: (valid) {
                  return Validates.isHasData(
                    minLength: 4,
                    data: cubit.number.text,
                    errorMessage: context.tr.pleaseEnterAccountNumber,
                  );
                },
              ).addPadding(bottom: 21.0),
              MPasswordWidget(
                unActiveSize: 18.0,
                activeSize: 24.0,
                activeColor: context.colorScheme.onSurface,
                unActiveColor: context.colorScheme.onSurface,
                child: (icon, hide) {
                  return MTextFiled(
                    hintText: context.tr.password,
                    controller: cubit.password,
                    textSize: FoontSize.font18,
                    hintSize: FoontSize.font16,
                    keyboardType: TextInputType.text,
                    contentPadding:
                        MPadding.set(horizontal: 21.0, vertical: 14.0),
                    hintColor: context.colorScheme.onSurface,
                    textColor: context.colorScheme.onSurface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: context.colorScheme.surfaceContainer,
                    validator: (valid) {
                      return Validates.isHasData(
                        minLength: 5,
                        data: cubit.password?.text ?? "",
                        errorMessage: context.tr.pleaseEnterPassword,
                      );
                    },
                    suffix: icon,
                    obscureText: hide,
                  ).addPadding(bottom: 21.0);
                },
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: FlowBuilder<ConnectCubit>(
                  onSuccess: (state, cubit) {
                    cubit.number.clear();
                    cubit.password?.clear();
                  },
                  builder: (context, state, cubit) {
                    return MBouncingButton(
                      width: double.infinity,
                      color: context.colorScheme.primary,
                      height: 55.0,
                      title: context.tr.switch_,
                      borderRadius: 8.0,
                      onTap: () {
                        widget.onAddNewAccount!(
                          cubit.number.text,
                          cubit.password?.text ?? "",
                          cubit.serverUrl ?? getIt<Sockeet>().socketUrl ?? "",
                        );
                        AutoRouterX(context).pop();
                      },
                    ).addPadding(top: 50.0, bottom: 30.0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
