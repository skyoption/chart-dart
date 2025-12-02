import 'package:auto_route/auto_route.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/bottom_sheet_item_widget.dart';
import 'package:example/core/shared/top_bottom_sheet_widget.dart';

class TradeDropdownItemWidget<T> extends StatefulWidget {
  final String? title;
  final T? initial;
  final List<T> options;
  final Color? backgroundColor, borderColor, color, fillColor;
  final Function(T item) onTap;
  final String Function(T item) onName;
  final bool isOutline;
  final String? searchTitle;
  final double? height, width;
  final EdgeInsetsGeometry? padding;
  final Widget? prefix;

  const TradeDropdownItemWidget({
    super.key,
    this.title,
    this.height,
    this.initial,
    this.backgroundColor,
    this.prefix,
    this.color,
    this.borderColor,
    this.padding,
    this.searchTitle,
    this.width,
    this.fillColor,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          MText(
            text: widget.title,
            color: context.colorScheme.onSurface,
            size: FoontSize.font17,
            weight: FontWeight.w400,
          ).addPadding(bottom: 10.0),
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.fillColor ??
                (widget.isOutline
                    ? null
                    : context.colorScheme.surfaceContainer),
            border: widget.isOutline
                ? Border.all(
                    color: widget.borderColor ?? context.colorScheme.outline,
                  )
                : null,
            borderRadius: MBorderRadius.set(all: 8.0),
          ),
          padding: widget.padding ??
              const MPadding.set(vertical: 12.0, horizontal: 16.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (widget.prefix != null) widget.prefix!,
                  MText(
                    text: item == null ? '' : widget.onName(item!),
                    color: widget.color ?? context.colorScheme.onSurface,
                    size: FoontSize.font16,
                    weight: FontWeight.w400,
                  ),
                ],
              ).addPadding(end: 12.0),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: widget.color ?? context.colorScheme.onSurface,
                size: 30.0,
              ),
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
              initial: widget.initial,
              onName: widget.onName,
              options: widget.options,
              searchTitle: widget.searchTitle,
              title: widget.title,
            );
          },
        ),
      ],
    ).addPadding(bottom: 8.0);
  }
}

class TradeBottomSheet<T> extends StatefulWidget {
  final List<T> options;
  final Function(T item) onTap;
  final String Function(T item) onName;
  final String? searchTitle, title;
  final T? initial;

  const TradeBottomSheet({
    super.key,
    required this.options,
    this.searchTitle,
    this.title,
    this.initial,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopBottomSheetWidget(),
        if (widget.title != null)
          MText(
            text: widget.title,
            color: context.colorScheme.onSurface,
            size: FoontSize.font18,
            weight: FontWeight.w600,
          ).addPadding(bottom: 16.0, horizontal: 21.0),
        if (widget.searchTitle != null)
          MTextFiled(
            onChanged: (value) {
              keyword = value;
              setState(() {});
            },
            hintText: widget.searchTitle,
            textColor: context.colorScheme.onSurface,
            titleColor: context.colorScheme.onSurface,
            hintColor: context.colorScheme.onSurfaceDisabled,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            activeBorderColor: Colors.transparent,
            fillColor: context.colorScheme.surfaceContainerLow,
            contentPadding: const MPadding.set(horizontal: 12.0),
            textSize: FoontSize.font15,
            hintSize: FoontSize.font15,
            keyboardType: TextInputType.text,
            prefix: MSvg(
              name: Svgs.search,
              color: context.colorScheme.onSurface,
              width: 21.0,
              height: 21.0,
            ).addPadding(start: 6.0, end: 12.0),
          ).addPadding(bottom: 30.0, horizontal: 21.0),
        ...widget.options.map((item) {
          if (!widget
              .onName(item)
              .toLowerCase()
              .contains(keyword.toLowerCase())) {
            return const SizedBox();
          }
          return BottomSheetItemWidget(
            isSelected: widget.initial == item,
            title: widget.onName(item),
            onTap: () {
              widget.onTap(item);
              context.router.pop();
            },
          );
        }),
      ],
    ).addPadding(bottom: 40.0);
  }
}

void showTradeBottomSheet<T>({
  required BuildContext context,
  required List<T> options,
  required Function(T item) onTap,
  required String Function(T item) onName,
  required String? searchTitle,
  required String? title,
  required T? initial,
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
      initial: initial,
      onName: onName,
      searchTitle: searchTitle,
      title: title,
    ),
  );
}
