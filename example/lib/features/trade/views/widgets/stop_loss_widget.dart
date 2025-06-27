import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/open_position_screen.dart';
import 'package:example/features/trade/views/widgets/trade_textfiled_item_widget.dart';

class StopLossWidget extends StatefulWidget {
  final PositionType type;
  final double price;
  final double? init;
  final bool enable;
  final ValueChanged<double>? onChange;
  const StopLossWidget({
    super.key,
    required this.type,
    required this.price,
    this.enable = true,
    this.onChange,
    this.init,
  });

  @override
  State<StopLossWidget> createState() => _StopLossWidgetState();
}

class _StopLossWidgetState extends State<StopLossWidget> {
  double price = 0;
  @override
  void initState() {
    if (widget.init != null) {
      price = widget.init!;
      if (widget.onChange != null) widget.onChange!(price.toTwoDecimalNum);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TradeTextFiledItemWidget(
      title: context.tr.stopLossTitle,
      init: widget.init,
      onChange: (value) {
        price = double.tryParse(value) ?? 0.0;
        if (widget.onChange != null) widget.onChange!(price);
      },
      enable: widget.enable,
      validator: (messageError) {
        if (price == 0) return null;
        if (widget.type == PositionType.ask) {
          return price < widget.price ? null : context.tr.invalid;
        } else if (widget.type == PositionType.bid) {
          return price > widget.price ? null : context.tr.invalid;
        }
        return null;
      },
    );
  }
}
