import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/time_picker.dart';
import 'package:example/features/chart/views/widgets/symbol_options_widget.dart';
import 'package:example/features/trade/views/widgets/trade_dropdown_item_widget.dart';
import 'package:example/features/trade_history/views/bottom_sheets/date_time_bottom_sheet.dart';

enum ExpirationOptions {
  GTC,
  Today,
  Specified,
}

class PositionExpirationTypeWidget extends StatefulWidget {
  final TransactionOptions? transactionOption;
  final Function(int expiration) onTap;

  const PositionExpirationTypeWidget({
    super.key,
    required this.onTap,
    this.transactionOption,
  });

  @override
  State<PositionExpirationTypeWidget> createState() =>
      _PositionExpirationTypeWidgetState();
}

class _PositionExpirationTypeWidgetState
    extends State<PositionExpirationTypeWidget> {
  final controller = TextEditingController();
  late ItemEntity type = types[0];

  late final types = [
    ItemEntity(
      name: context.tr.gtcMode,
      value: ExpirationOptions.GTC,
    ),
    ItemEntity(
      name: context.tr.today,
      value: ExpirationOptions.Today,
    ),
    ItemEntity(
      name: context.tr.specified,
      value: ExpirationOptions.Specified,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.transactionOption == TransactionOptions.market_order) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TradeDropdownItemWidget<ItemEntity>(
          title: context.tr.expiration,
          initial: type,
          options: types,
          borderColor: context.isDarkTheme
              ? Colors.transparent
              : context.colorScheme.outline,
          onTap: (item) {
            type = item;
            setState(() {});
            if (item.value == ExpirationOptions.Specified) {
              Future.delayed(
                const Duration(milliseconds: 700),
                () => _showTimePicker(
                  onChange: (date) {
                    widget.onTap(date?.millisecondsSinceEpoch ?? 0);
                  },
                ),
              );
            }
            if (type.value == ExpirationOptions.GTC) {
              widget.onTap(0);
            } else if (type.value == ExpirationOptions.Today) {
              final today = DateTime.now()
                  .copyWith(hour: 23, minute: 59, second: 59)
                  .toUtc()
                  .millisecondsSinceEpoch;
              widget.onTap(today);
            }
          },
          onName: (item) => item.name,
        ),
        if (type.value == ExpirationOptions.Specified)
          Row(
            children: [
              Expanded(
                child: MText(
                  text: context.tr.time,
                  color: context.colorScheme.onSurface,
                  size: FoontSize.font19,
                ),
              ),
              Expanded(
                child: MTextFiled(
                  enabled: false,
                  controller: controller,
                  titlePadding: const MPadding.set(bottom: 8.0),
                  hintText: context.tr.chooseTime,
                  textColor: context.colorScheme.onSurface,
                  titleColor: context.colorScheme.onSurface,
                  hintColor: context.colorScheme.onSurfaceVariant,
                  // controller: cubit.number,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: context.colorScheme.outline,
                    ),
                  ),
                  contentPadding: const MPadding.set(all: 16.0),
                  titleWeight: FontWeight.w500,
                  textSize: FoontSize.font16,
                  titleSize: FoontSize.font16,
                ).addAction(
                  padding: const MPadding.set(bottom: 12.0),
                  onGesture: () {
                    _showTimePicker(
                      onChange: (date) {
                        widget.onTap(date?.toUtc().millisecondsSinceEpoch ?? 0);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
      ],
    ).addPadding(top: 12.0);
  }

  void _showTimePicker({
    required Function(DateTime?) onChange,
  }) {
    showMDateTimePicker(
      context: context,
      onChange: (date) {
        if (date != null) {
          controller.text = date.timeAndDate;
          onChange(date);
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
