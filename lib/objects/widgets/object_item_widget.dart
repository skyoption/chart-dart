import 'package:candle_chart/objects/widgets/svg.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class ObjectItemWidget extends StatefulWidget {
  final String? icon, title, subtitle;
  final Function onTap;
  final Function? onDelete;
  final double? iconSize;
  final Widget? child;
  final Color? color;
  final bool hideArrow;
  final String? id;

  const ObjectItemWidget({
    super.key,
    this.icon,
    this.title,
    this.child,
    this.color,
    this.subtitle,
    this.id,
    this.onDelete,
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
        color: Colors.grey.withOpacity(0.2),
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 16.0,
          horizontal: 21.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (widget.iconSize != null && widget.icon != null)
                  Container(
                    width: widget.iconSize! + 5,
                    margin: EdgeInsetsDirectional.only(end: 12.0),
                    child: MSvg(
                      name: widget.icon,
                      width: widget.iconSize,
                      height: widget.iconSize,
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: widget.color,
                          ),
                    ),
                    if (widget.subtitle != null)
                      Text(
                        widget.subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
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
                color: widget.color ?? Colors.black,
              )
          ],
        ),
      ),
    );
    if (widget.id == null) {
      return child.addPadding(bottom: 8.0);
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
      background: Container(
        color: Colors.red.withOpacity(0.1),
        child: Padding(
          padding: MPadding.set(horizontal: 21.0),
          child: Row(
            mainAxisAlignment: direction == DismissDirection.startToEnd
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete_outline_outlined,
                color: Colors.red,
                size: 28.0,
              ),
            ],
          ),
        ),
      ),
      child: child,
    ).addPadding(bottom: 8.0);
  }
}
