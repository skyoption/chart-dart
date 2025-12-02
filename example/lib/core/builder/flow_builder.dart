import 'package:auto_route/auto_route.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/core/shared/loading.dart';

export 'flow_state.dart';

class FlowBuilder<C extends Cubit<FlowState>> extends StatefulWidget {
  final Widget Function(BuildContext context, FlowState state, C cubit) builder;
  final Function(BuildContext context, FlowState state, C cubit)? listener;
  final bool Function(FlowState previous, FlowState current)? buildWhenState;
  final bool Function(C cubit)? buildWhenCubit;
  final Widget? error, loading;
  final String? successMessage, errorMessage;
  final Function(FlowState state, C cubit)? onSuccess, onError;

  const FlowBuilder({
    super.key,
    required this.builder,
    this.listener,
    this.loading,
    this.error,
    this.successMessage,
    this.errorMessage,
    this.buildWhenState,
    this.buildWhenCubit,
    this.onSuccess,
    this.onError,
  });

  @override
  State<FlowBuilder> createState() => _FlowBuilderState<C>();
}

class _FlowBuilderState<C extends Cubit<FlowState>>
    extends State<FlowBuilder<C>> {
  bool popUpOpened = false;
  BuildContext? _dialogContext;
  late C cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<C>();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BlocConsumer<C, FlowState>(
        buildWhen: (previous, current) {
          if (widget.buildWhenState != null) {
            return widget.buildWhenState!(previous, current);
          }
          if (widget.buildWhenCubit != null) {
            return widget.buildWhenCubit!(cubit);
          }
          return true;
        },
        builder: (context, state) {
          final cubit = context.read<C>();
          if (state.type == StateType.error) {
            return widget.error ?? const SizedBox();
          } else if (state.type == StateType.loading) {
            return widget.loading ??
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  child: Center(child: Loading.loader(context)),
                );
          }
          return widget.builder(context, state, cubit);
        },
        listener: (context, state) {
          final cubit = context.read<C>();
          // Dismiss popup if it's open and we're transitioning to a non-popup state
          if (popUpOpened && state.type != StateType.loadingPopUp) {
            popUpOpened = false;
            if (_dialogContext != null && _dialogContext!.mounted) {
              Navigator.of(_dialogContext!, rootNavigator: true).pop();
              _dialogContext = null;
            }
          }

          if (!popUpOpened && state.type == StateType.loadingPopUp) {
            popUpOpened = true;
          }

          if (state.type == StateType.loadingPopUp) {
            FocusManager.instance.primaryFocus?.unfocus();
            showAdaptiveDialog(
              context: context,
              barrierDismissible: false,
              useRootNavigator: true,
              builder: (dialogContext) {
                _dialogContext = dialogContext;
                return Loading.loader(dialogContext);
              },
            );
          } else if (state.type == StateType.successPopUp) {
            if (widget.onSuccess != null) {
              widget.onSuccess!(state, cubit);
            } else {
              MToast.showSuccess(
                message: widget.successMessage ?? '${state.message}',
              );
            }
          } else if (state.type == StateType.errorPopUp) {
            if (widget.onError != null) {
              widget.onError!(state, cubit);
            } else {
              MToast.showError(
                message: widget.errorMessage ?? '${state.message}',
              );
            }
          } else if (state.type == StateType.success) {
            if (widget.onSuccess != null) widget.onSuccess!(state, cubit);
          } else if (state.type == StateType.error) {
            if (widget.onError != null) widget.onError!(state, cubit);
          }
          if (widget.listener != null) {
            widget.listener!(context, state, cubit);
          }
        },
      ),
    );
  }
}
