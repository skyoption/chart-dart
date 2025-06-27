import 'dart:math';

import 'package:example/core/consts/exports.dart';

class TradeTextFiledItemWidget extends StatefulWidget {
  final String? title;
  final Function(String value) onChange;
  final double max, min, step;
  final Color? color;
  final EdgeInsetsGeometry? contentPadding;
  final double? init;
  final int digits;
  final String? Function(String? messageError)? validator;
  final bool enable, removeBorder;

  const TradeTextFiledItemWidget({
    super.key,
    this.title,
    required this.onChange,
    this.validator,
    this.color,
    this.contentPadding,
    this.max = 10,
    this.min = 0.1,
    this.step = 0.1,
    this.digits = 4,
    this.enable = true,
    this.removeBorder = false,
    this.init,
  });

  @override
  State<TradeTextFiledItemWidget> createState() =>
      _TradeTextFiledItemWidgetState();
}

class _TradeTextFiledItemWidgetState extends State<TradeTextFiledItemWidget> {
  double value = 0;
  final controller = TextEditingController();

  @override
  void initState() {
    if (widget.init != null) {
      value = widget.init!;
    }
    controller.text = value.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MTextFiled(
      title: widget.title,
      titleColor: context.colorScheme.scrim,
      controller: controller,
      titleSize: FoontSize.font17,
      textSize: FoontSize.font16,
      hintSize: FoontSize.font16,
      titlePadding: const MPadding.set(bottom: 6.0),
      suffix: Icon(
        Icons.add,
        color: context.colorScheme.primary,
      ).addAction(
        onGesture: () {
          if (value < widget.max) {
            value += widget.step;
            controller.text = value.toStringAsFixed(widget.digits);
            widget.onChange(value.toString());
          }
        },
      ),
      fillColor: widget.color,
      validator: widget.validator,
      prefix: Icon(
        Icons.remove,
        color: context.colorScheme.primary,
      ).addAction(
        onGesture: () {
          if (value > widget.min) {
            value -= widget.step;
            controller.text = value.toStringAsFixed(widget.digits);
            widget.onChange(value.toString());
          }
        },
      ),
      inputFiltering: [
        DecimalTextInputFormatter(decimalRange: 2),
      ],
      enabled: widget.enable,
      hintText: context.tr.enterValue,
      hintWeight: FontWeight.w300,
      hintColor: context.colorScheme.onSurface,
      activeBorderColor: context.colorScheme.scrim,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: widget.removeBorder
            ? BorderSide.none
            : BorderSide(color: context.colorScheme.outline),
      ),
      textAlign: TextAlign.center,
      textColor: context.colorScheme.scrim,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      onChanged: (value) {
        this.value = double.tryParse(value) ?? 0.0;
        widget.onChange(value);
      },
      contentPadding: widget.contentPadding ??
          const MPadding.set(
            vertical: 14.0,
            horizontal: 12.0,
          ),
    ).addPadding(bottom: 8.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    String value = newValue.text;

    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";

      newSelection = newValue.selection.copyWith(
        baseOffset: min(truncated.length, truncated.length + 1),
        extentOffset: min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}
