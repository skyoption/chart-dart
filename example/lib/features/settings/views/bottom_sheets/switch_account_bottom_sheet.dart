import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/bottom_sheet_item_widget.dart';

class SwitchAccountBottomSheet extends StatefulWidget {
  final Function onSwitch;
  final Function onDelete;

  const SwitchAccountBottomSheet({
    super.key,
    required this.onSwitch,
    required this.onDelete,
  });

  @override
  State<SwitchAccountBottomSheet> createState() =>
      _SwitchAccountBottomSheetState();
}

class _SwitchAccountBottomSheetState extends State<SwitchAccountBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetItemWidget(
          icon: Svgs.switchIcon,
          title: context.tr.switchToThisAccount,
          onTap: widget.onSwitch,
          isDivider: false,
        ),
        MDividerItemWidget(
          padding: MPadding.set(vertical: 21.0),
          color: context.colorScheme.outline,
        ),
        BottomSheetItemWidget(
          title: context.tr.deleteAccount,
          icon: Svgs.delete,
          onTap: widget.onDelete,
          isDivider: false,
        ),
      ],
    ).addPadding(bottom: 50.0, horizontal: 21.0);
  }
}

void showSwitchAccountBottomSheet({
  required BuildContext context,
  required Function onSwitch,
  required Function onDelete,
}) {
  showMBottomSheet(
    context: context,
    borderRadius: MBorderRadius.set(all: 12.0),
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: SwitchAccountBottomSheet(
      onSwitch: onSwitch,
      onDelete: onDelete,
    ),
  );
}
