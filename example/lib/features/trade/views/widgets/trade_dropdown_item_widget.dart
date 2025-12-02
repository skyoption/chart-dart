import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/bottom_sheet_item_widget.dart';

class TradeDropdownItemWidget<T> extends StatefulWidget {
  final String? title;
  final T? initial;
  final List<T> options;
  final Color? backgroundColor, borderColor;
  final Function(T item) onTap;
  final String Function(T item) onName;
  final bool isOutline;
  final String? searchTitle;
  final double? height, width;

  const TradeDropdownItemWidget({
    super.key,
    this.title,
    this.height,
    this.initial,
    this.backgroundColor,
    this.borderColor,
    this.searchTitle,
    this.width,
    this.isOutline = true,
    required this.options,
    required this.onTap,
    required this.onName,
  });

  @override
  State<TradeDropdownItemWidget<T>> createState() =>
      _TradeDropdownItemWidgetState<T>();
}

class _TradeDropdownItemWidgetState<T>
    extends State<TradeDropdownItemWidget<T>> {
  T? item;

  @override
  void initState() {
    if (widget.initial != null) {
      item = widget.initial;
    } else if (widget.options.isNotEmpty) {
      item = widget.options[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.title != null)
          MText(
            text: widget.title,
            color: context.colorScheme.onSurface,
            size: FoontSize.font17,
            weight: FontWeight.w600,
          ).addPadding(bottom: 10),
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color:
                widget.isOutline ? null : context.colorScheme.surfaceContainer,
            border: widget.isOutline
                ? Border.all(color: context.colorScheme.outline)
                : null,
            borderRadius: MBorderRadius.set(all: 8.0),
          ),
          padding: const MPadding.set(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MText(
                text: item == null ? '' : widget.onName(item!),
                color: context.colorScheme.onSurface,
                size: FoontSize.font19,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.colorScheme.onSurface,
                size: 30.0,
              )
            ],
          ),
        ).addAction(
          onGesture: () {
            showTradeBottomSheet<T>(
              context: context,
              onTap: (item) {
                this.item = item;
                setState(() {});
                widget.onTap(item);
              },
              onName: widget.onName,
              options: widget.options,
              searchTitle: widget.searchTitle,
            );
          },
        )
      ],
    ).addPadding(bottom: 14.0);
  }
}

class TradeBottomSheet<T> extends StatefulWidget {
  final List<T> options;
  final Function(T item) onTap;
  final String Function(T item) onName;
  final String? searchTitle;

  const TradeBottomSheet({
    super.key,
    required this.options,
    this.searchTitle,
    required this.onTap,
    required this.onName,
  });

  @override
  State<TradeBottomSheet<T>> createState() => _TradeBottomSheetState<T>();
}

class _TradeBottomSheetState<T> extends State<TradeBottomSheet<T>> {
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.searchTitle != null)
          MTextFiled(
            prefix: const MSvg(
              name: Svgs.search,
              height: 21.0,
              width: 21.0,
            ),
            onChanged: (value) {
              keyword = value;
              setState(() {});
            },
            hintText: widget.searchTitle,
            hintColor: context.colorScheme.onSurfaceVariant,
            textColor: context.colorScheme.onSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            fillColor: context.colorScheme.surface,
            textSize: FoontSize.font18,
            keyboardType: TextInputType.text,
          ).addPadding(bottom: 30.0),
        ...widget.options.map((item) {
          if (!widget
              .onName(item)
              .toLowerCase()
              .contains(keyword.toLowerCase())) {
            return const SizedBox();
          }
          return BottomSheetItemWidget(
            title: widget.onName(item),
            onTap: () {
              widget.onTap(item);
              // AutoRouterX(context).pop();
            },
          );
        }),
      ],
    ).addPadding(vertical: 12.0, horizontal: 21.0);
  }
}

void showTradeBottomSheet<T>({
  required BuildContext context,
  required List<T> options,
  required Function(T item) onTap,
  required String Function(T item) onName,
  required String? searchTitle,
}) {
  showMBottomSheet(
    context: context,
    borderRadius: MBorderRadius.set(all: 12.0),
    removeTransparentBackground: true,
    noScrolling: searchTitle != null,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: TradeBottomSheet<T>(
      onTap: onTap,
      options: options,
      onName: onName,
      searchTitle: searchTitle,
    ),
  );
}
