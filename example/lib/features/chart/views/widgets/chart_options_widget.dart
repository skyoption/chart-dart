import 'package:candle_chart/k_chart_plus.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/views/widgets/style_widget.dart';

class ChartOptionsWidget extends StatefulWidget {
  final ValueNotifier<GraphStyle> graphStyle;
  final ValueNotifier<bool> hideGrid;
  final Function(GraphStyle graphStyle) onChangeStyle;
  final Function openObjects;
  final Function openFunctions;
  final Function(bool cursor) onCursor;
  const ChartOptionsWidget({
    super.key,
    required this.hideGrid,
    required this.graphStyle,
    required this.onChangeStyle,
    required this.openObjects,
    required this.openFunctions,
    required this.onCursor,
  });

  @override
  State<ChartOptionsWidget> createState() => _ChartOptionsWidgetState();
}

class _ChartOptionsWidgetState extends State<ChartOptionsWidget> {
  final controller = ExpansibleController();
  late final ValueNotifier<bool> isExpanded;
  bool cursor = false;
  @override
  void initState() {
    isExpanded = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (context.isLandscape) {
      return Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: MBorderRadius.set(all: 10.0),
        ),
        padding: MPadding.set(horizontal: 12.0, vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            title(),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: _expanded ? 24.0 : 0,
              height: _expanded ? 230 : 0,
              curve: Curves.easeInOut,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: children(),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      width: 45.0,
      child: ExpansionTile(
        controller: controller,
        backgroundColor: context.colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: MBorderRadius.set(all: 10.0),
          side: BorderSide.none,
        ),
        minTileHeight: 45.0,
        collapsedBackgroundColor: context.colorScheme.surfaceContainer,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: MBorderRadius.set(all: 10.0),
          side: BorderSide.none,
        ),
        showTrailingIcon: false,
        expansionAnimationStyle: AnimationStyle(
          duration: Durations.long1,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
          reverseDuration: Durations.long1,
        ),
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        collapsedIconColor: context.colorScheme.onSurface,
        iconColor: context.colorScheme.onSurface,
        onExpansionChanged: (value) {
          isExpanded.value = value;
        },
        title: title(),
        children: children(),
      ),
    );
  }

  Widget title() => ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (context, expanded, child) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: MSvg(
              name: Svgs.chartSettings,
              width: 24.0,
              height: 24.0,
              color: context.colorScheme.onSurface,
            ).addAction(
              padding: MPadding.set(
                top: expanded ? 8.0 : 0.0,
                bottom: expanded ? 12.0 : 0.0,
              ),
              onTap: () {
                if (context.isLandscape) {
                  setState(() {
                    _expanded = !_expanded;
                  });
                } else {
                  if (!expanded) {
                    controller.expand();
                  } else {
                    isExpanded.value = false;
                    controller.collapse();
                  }
                }
              },
            ),
          );
        },
      );

  List<Widget> children() => [
        MSvg(
          name: Svgs.functions,
          width: 24.0,
          height: 24.0,
          color: context.colorScheme.onSurface,
        ).addAction(
          padding: MPadding.set(
            top: context.isLandscape ? 16.0 : 0.0,
            bottom: context.isLandscape ? 12.0 : 21.0,
            start: context.isLandscape ? 0.0 : 0.0,
          ),
          onTap: () {
            isExpanded.value = false;
            controller.collapse();
            widget.openFunctions();
          },
        ),
        MSvg(
          name: Svgs.objects,
          width: 24.0,
          height: 24.0,
          color: context.colorScheme.onSurface,
        ).addAction(
          padding: MPadding.set(
            bottom: context.isLandscape ? 12.0 : 21.0,
            start: context.isLandscape ? 0.0 : 0.0,
          ),
          onTap: () {
            isExpanded.value = false;
            controller.collapse();
            widget.openObjects();
          },
        ),
        MSvg(
          name: Svgs.cursor,
          width: 24.0,
          height: 24.0,
          color: context.colorScheme.onSurface,
        ).addAction(
          padding: MPadding.set(
            bottom: context.isLandscape ? 12.0 : 21.0,
            start: context.isLandscape ? 0.0 : 0.0,
          ),
          onTap: () {
            cursor = !cursor;
            isExpanded.value = false;
            controller.collapse();
            widget.onCursor(cursor);
          },
        ),
        StyleWidget(
          graphStyle: widget.graphStyle,
          onGraphStyleChanged: widget.onChangeStyle,
          onGesture: () {
            isExpanded.value = false;
            controller.collapse();
          },
        ).addPadding(
          bottom: context.isLandscape ? 12.0 : 21.0,
          start: context.isLandscape ? 0.0 : 0.0,
        ),
        ValueListenableBuilder<bool>(
          valueListenable: widget.hideGrid,
          builder: (context, hideGrid, child) {
            return MSvg(
              name: Svgs.grid,
              width: 24.0,
              height: 24.0,
              color: context.colorScheme.onSurface,
            ).addAction(
              padding: MPadding.set(
                bottom: context.isLandscape ? 12.0 : 21.0,
                start: context.isLandscape ? 0.0 : 0.0,
              ),
              onTap: () {
                isExpanded.value = false;
                controller.collapse();
                widget.hideGrid.value = !hideGrid;
              },
            );
          },
        ),
        Icon(
          Icons.keyboard_arrow_up_rounded,
          size: 21.0,
          color: context.colorScheme.onSurface,
        ).addAction(
          padding: MPadding.set(
            bottom: context.isLandscape ? 12.0 : 21.0,
            start: context.isLandscape ? 0.0 : 0.0,
          ),
          onTap: () {
            if (context.isLandscape) {
              _expanded = false;
              setState(() {});
            } else {
              controller.collapse();
              isExpanded.value = false;
            }
          },
        ),
      ];
}
