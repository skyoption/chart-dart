import 'package:example/core/consts/exports.dart';

class TabItem {
  final String name;
  final String? icon;

  TabItem({required this.name, this.icon});
}

class ScrollableTabsWidget extends StatefulWidget {
  final List<TabItem> tabs;
  final Function(int index) onChange;
  final List<Widget>? children;
  final List<Widget>? header;
  final Color? color;
  final double borderRadius, fontSize;
  final EdgeInsetsGeometry? padding, margin;
  final bool showTabs;

  const ScrollableTabsWidget({
    super.key,
    required this.tabs,
    required this.onChange,
    this.children,
    this.header,
    this.margin,
    this.color,
    this.padding,
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
    this.showTabs = true,
  });

  @override
  State<ScrollableTabsWidget> createState() => _ScrollableTabsWidgetState();
}

class _ScrollableTabsWidgetState extends State<ScrollableTabsWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        if (widget.header != null)
          SliverToBoxAdapter(child: widget.header![index]),
        if (widget.showTabs)
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceDisabled,
                borderRadius: MBorderRadius.set(all: widget.borderRadius),
              ),
              margin: widget.margin,
              alignment: Alignment.center,
              child: Row(
                children: widget.tabs.asMap().entries.map((item) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: index == item.key
                            ? widget.color ?? context.colorScheme.primary
                            : context.colorScheme.surfaceDisabled,
                        borderRadius: MBorderRadius.set(
                          all: widget.borderRadius,
                        ),
                      ),
                      padding:
                          widget.padding ?? const MPadding.set(vertical: 12.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (item.value.icon != null)
                            MSvg(
                              name: item.value.icon,
                              width: 22.0,
                              height: 22.0,
                              color: index == item.key
                                  ? context.colorScheme.onSurface
                                  : context.colorScheme.onSurfaceDisabled,
                            ).addPadding(end: 5.0),
                          MText(
                            text: item.value.name,
                            color: index == item.key
                                ? context.colorScheme.onPrimary
                                : context.colorScheme.onSurfaceDisabled,
                            size: widget.fontSize,
                            weight: FontWeight.w300,
                          ),
                        ],
                      ),
                    ).addAction(
                      onGesture: () {
                        setState(() {
                          index = item.key;
                        });
                        widget.onChange(index);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
      body: widget.children != null
          ? widget.showTabs
              ? widget.children![index]
              : widget.children!.first
          : const SizedBox.shrink(),
    );
  }
}
