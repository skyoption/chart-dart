import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/widgets/delete_widget.dart';
import 'package:candle_chart/objects/widgets/svg.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:candle_chart/widgets/radius.dart';
import 'package:flutter/material.dart';

class ObjectItemWidget extends StatefulWidget {
  final String? icon, title, subtitle;
  final Function onTap;
  final Function? onDelete;
  final double? iconSize;
  final Widget? child;
  final Color? color;
  final Color? backgroundColor;
  final bool hideArrow;
  final String? id;
  final EdgeInsets? margin;

  const ObjectItemWidget({
    super.key,
    this.icon,
    this.title,
    this.child,
    this.color,
    this.backgroundColor,
    this.subtitle,
    this.id,
    this.onDelete,
    this.margin,
    required this.onTap,
    this.iconSize = 25.0,
    this.hideArrow = false,
  });

  @override
  State<ObjectItemWidget> createState() => _ObjectItemWidgetState();
}

class _ObjectItemWidgetState extends State<ObjectItemWidget> {
  DismissDirection? direction;

  @override
  Widget build(BuildContext context) {
    final child = GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: context.scheme.surfaceBright,
          borderRadius: MBorderRadius.set(all: 8.0),
        ),
        margin: MPadding.set(horizontal: 21.0),
        padding: MPadding.set(horizontal: 21.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (widget.iconSize != null && widget.icon != null)
                  Container(
                    width: widget.iconSize! + 5,
                    margin: MPadding.set(end: 12.0),
                    child: MSvg(
                      name: widget.icon,
                      width: widget.iconSize,
                      height: widget.iconSize,
                      color: widget.color ?? context.scheme.onSurface,
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title!,
                      style: context.text.bodySmall!.copyWith(
                        color: widget.color ?? context.scheme.onSurface,
                      ),
                    ),
                    if (widget.subtitle != null)
                      Text(
                        widget.subtitle!,
                        style: context.text.bodySmall,
                      ),
                  ],
                ),
              ],
            ),
            if (widget.child != null) widget.child!,
            if (widget.child == null && !widget.hideArrow)
              Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20.0,
                color: widget.color ?? context.scheme.onSurface,
              )
          ],
        ),
      ),
    );
    if (widget.id == null) {
      return Padding(
        padding: widget.margin ?? MPadding.set(bottom: 8.0),
        child: child,
      );
    }
    return Dismissible(
      key: Key(widget.id!),
      onUpdate: (details) {
        direction = details.direction;
        setState(() {});
      },
      onDismissed: (value) {
        if (widget.onDelete != null) widget.onDelete!();
      },
      background: DeleteWidget(direction: direction),
      child: child,
    ).addPadding(bottom: 12.0);
  }
}
