import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/column_value_item_widget.dart';
import 'package:example/core/widgets/switcher_widget.dart';

class PlatformSwitchItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  const PlatformSwitchItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<PlatformSwitchItem> createState() => _PlatformSwitchItemState();
}

class _PlatformSwitchItemState extends State<PlatformSwitchItem> {
  late final ValueNotifier<bool> _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier(widget.initialValue);
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const MPadding.set(vertical: 16.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Coolors.borderColor,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ColumnValueItemWidget(
            title: widget.title,
            titleFontSize: FoontSize.font17,
            titleWeight: FontWeight.w400,
            titleColor: context.colorScheme.onSurface,
            subTitle: widget.subtitle,
            subTitleColor: context.colorScheme.onSurface,
            subTitleFontSize: FoontSize.font13,
            subTitleWeight: FontWeight.w400,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _notifier,
            builder: (context, value, child) {
              return MSwitchWidget(
                value: value,
                onChanged: (newValue) {
                  _notifier.value = newValue;
                  widget.onChanged?.call(newValue);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
