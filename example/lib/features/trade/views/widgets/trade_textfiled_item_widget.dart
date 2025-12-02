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
  final Widget? suffix;
  final double bottomPadding;

  const TradeTextFiledItemWidget({
    super.key,
    this.title,
    required this.onChange,
    this.validator,
    this.color,
    this.contentPadding,
    this.suffix,
    this.max = double.infinity,
    this.min = 0.1,
    this.step = 0.1,
    this.digits = 4,
    this.enable = true,
    this.removeBorder = false,
    this.init,
    this.bottomPadding = 8.0,
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
    super.initState();
    if (widget.init != null) {
      value = widget.init!;
      controller.text = value.toStringAsFixed(widget.digits);
      widget.onChange(value.toString());
    } else {
      controller.text = value.toString();
    }
  }

  @override
  void didUpdateWidget(TradeTextFiledItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the value when init parameter changes (e.g., when symbol changes)
    if (widget.init != null && widget.init != oldWidget.init) {
      value = widget.init!;
      Future.delayed(Duration.zero, () {
        controller.text = value.toStringAsFixed(widget.digits);
        // Defer the onChange call to avoid setState during build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onChange(value.toString());
        });
      });
    }
    if (widget.max != oldWidget.max || widget.min != oldWidget.min) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTextFiled(
      title: widget.title,
      titleColor: context.colorScheme.onSurface,
      controller: controller,
      titleSize: context.isLandscape ? FoontSize.font14 : FoontSize.font15,
      textSize: context.isLandscape ? FoontSize.font14 : FoontSize.font15,
      hintSize: context.isLandscape ? FoontSize.font14 : FoontSize.font15,
      titlePadding: const MPadding.set(bottom: 6.0),
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.suffix != null) widget.suffix!,
          Icon(
            Icons.add,
            color: context.colorScheme.primary,
            size: context.isLandscape ? 18.0 : 24.0,
          ).addAction(
            padding: const MPadding.set(end: 10.0),
            onGesture: () {
              if (value < widget.max) {
                value += widget.step;
                controller.text = value.toStringAsFixed(widget.digits);
                widget.onChange(value.toString());
              }
            },
          ),
        ],
      ),
      fillColor: widget.color ?? context.colorScheme.surfaceContainerLow,
      validator: widget.validator,
      prefix: Icon(
        Icons.remove,
        color: context.colorScheme.primary,
        size: context.isLandscape ? 18.0 : 24.0,
      ).addAction(
        onGesture: () {
          if (value > widget.min) {
            value -= widget.step;
            controller.text = value.toStringAsFixed(widget.digits);
            widget.onChange(value.toString());
          }
        },
      ),
      inputFiltering: [DecimalTextInputFormatter(decimalRange: widget.digits)],
      enabled: widget.enable,
      hintText: '0.00',
      hintWeight: FontWeight.w300,
      hintColor: context.colorScheme.onSurfaceVariant,
      activeBorderColor: context.colorScheme.onSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: widget.removeBorder
            ? BorderSide.none
            : BorderSide(color: context.colorScheme.outline),
      ),
      textAlign: TextAlign.center,
      textColor: context.colorScheme.onSurface,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      onChanged: (value) {
        this.value = double.tryParse(value) ?? 0.0;
        widget.onChange(value);
      },
      contentPadding: widget.contentPadding ??
          const MPadding.set(vertical: 13.0, horizontal: 12.0),
    ).addPadding(bottom: widget.bottomPadding);
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
