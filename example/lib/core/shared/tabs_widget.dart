import 'package:example/core/consts/exports.dart';

class TabItem {
  final String name;
  final String? icon;

  TabItem({required this.name, this.icon});
}

enum TabsType { fill, outline, separate }

class TabsWidget extends StatefulWidget {
  final List<TabItem> tabs;
  final Function(int index) onChange;
  final List<Widget>? children;
  final Widget? header;
  final Color? color;
  final double borderRadius, fontSize;
  final EdgeInsetsGeometry? padding, margin;
  final bool showTabs, iconTransparent;
  final TabsType type;
  final Widget? subWidget;
  final List<int> hideSubWidgetOnIndexes;
  final double? tabIconWidth, tabIconHeight;
  final bool isSliver;
  const TabsWidget({
    super.key,
    required this.tabs,
    required this.onChange,
    this.children,
    this.header,
    this.margin,
    this.type = TabsType.fill,
    this.color,
    this.padding,
    this.borderRadius = 8.0,
    this.fontSize = 15.0,
    this.showTabs = true,
    this.iconTransparent = false,
    this.subWidget,
    this.hideSubWidgetOnIndexes = const [],
    this.tabIconWidth,
    this.tabIconHeight,
    this.isSliver = false,
  });

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final body = Container(
      decoration: BoxDecoration(
        color: widget.type == TabsType.fill
            ? context.colorScheme.surfaceDisabled
            : Colors.transparent,
        borderRadius: MBorderRadius.set(all: widget.borderRadius),
      ),
      margin: widget.margin,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.tabs.asMap().entries.map((item) {
          final tabIndex = item.key;
          final tab = item.value;
          Widget tabWidget({double? width}) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: width,
                decoration: BoxDecoration(
                  color: _getTabBackgroundColor(tabIndex),
                  border: _getTabBorder(tabIndex),
                  borderRadius: MBorderRadius.set(all: widget.borderRadius),
                ),
                padding: widget.padding ??
                    MPadding.set(
                      vertical: widget.type == TabsType.separate ? 7.0 : 10.0,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (tab.icon != null)
                      MSvg(
                        name: tab.icon,
                        width: widget.tabIconWidth ?? 22.0,
                        height: widget.tabIconHeight ?? 22.0,
                        color: widget.iconTransparent
                            ? null
                            : _getTabTextColor(tabIndex),
                      ).addPadding(end: 5.0),
                    MText(
                      text: tab.name,
                      color: _getTabTextColor(tabIndex),
                      size: widget.fontSize,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
              ).addAction(
                onGesture: () {
                  setState(() => index = tabIndex);
                  widget.onChange(index);
                },
              );

          return widget.type == TabsType.separate
              ? tabWidget(
                  width: context.isLandscape
                      ? context.mWidth * 0.20
                      : context.mWidth * 0.27,
                )
              : Expanded(child: tabWidget());
        }).toList(),
      ),
    ).addPadding(bottom: widget.children != null ? 21.0 : 0.0);
    if (widget.isSliver) {
      return CustomScrollView(
        slivers: [
          if (widget.header != null) SliverToBoxAdapter(child: widget.header!),
          if (widget.showTabs) SliverToBoxAdapter(child: body),
          if (widget.subWidget != null &&
              !widget.hideSubWidgetOnIndexes.contains(index))
            SliverToBoxAdapter(child: widget.subWidget!),
          if (widget.children != null)
            widget.showTabs ? widget.children![index] : widget.children!.first,
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).padding.bottom * 4.0,
            ),
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.header != null) widget.header!,
        if (widget.showTabs) body,
        if (widget.subWidget != null &&
            !widget.hideSubWidgetOnIndexes.contains(index))
          widget.subWidget!,
        if (widget.children != null)
          widget.showTabs ? widget.children![index] : widget.children!.first,
      ],
    );
  }

  Color _getTabBackgroundColor(int tabIndex) {
    final isSelected = index == tabIndex;

    switch (widget.type) {
      case TabsType.fill:
        return isSelected
            ? widget.color ?? context.colorScheme.primary
            : context.colorScheme.surfaceDisabled;
      case TabsType.outline:
        return Colors.transparent;
      case TabsType.separate:
        return isSelected
            ? widget.color ?? context.colorScheme.primary
            : context.colorScheme.surfaceDisabled;
    }
  }

  Color _getTabTextColor(int tabIndex) {
    final isSelected = index == tabIndex;

    if (widget.type == TabsType.outline) {
      return isSelected
          ? widget.color ?? context.colorScheme.primary
          : context.colorScheme.onSurfaceDisabled;
    } else {
      return isSelected
          ? context.colorScheme.onPrimary
          : context.colorScheme.onSurfaceDisabled;
    }
  }

  BoxBorder? _getTabBorder(int tabIndex) {
    final isSelected = index == tabIndex;

    if (widget.type == TabsType.outline && isSelected) {
      return Border.all(color: widget.color ?? context.colorScheme.primary);
    }
    return null;
  }
}
