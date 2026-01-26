import 'package:candle_chart/indicators/tabs/all_indicators_tab.dart';
import 'package:candle_chart/indicators/tabs/applied_indicators_tab.dart';
import 'package:candle_chart/indicators/tabs/favorites_indicators_tab.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/objects/widgets/svg.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/k_chart_plus.dart';

class IndicatorsScreen extends StatefulWidget {
  final Function onDone;

  const IndicatorsScreen({
    super.key,
    required this.onDone,
  });

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
  DismissDirection? direction;

  late final tabs = [
    TabItem(title: context.tr.all, index: 0),
    TabItem(title: context.tr.favorites, index: 1),
    TabItem(title: context.tr.applied, index: 2),
  ];

  final index = ValueNotifier(0);
  final search = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.indicators,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            style: context.text.bodySmall,
            decoration: InputDecoration(
              prefixIconConstraints: const BoxConstraints(
                minWidth: 20.0,
                minHeight: 20.0,
              ),
              prefixIcon: MSvg(
                name: Svgs.search,
                height: 20.0,
                width: 20.0,
                color: context.scheme.onSurface,
              ).addPadding(start: 16.0, end: 4.0),
              hintText: context.tr.searchByIndicatorName,
              hintStyle: context.text.bodySmall!.copyWith(
                color: context.scheme.onSurfaceDisabled,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: context.scheme.surfaceContainerLow,
              contentPadding: const MPadding.set(horizontal: 16.0),
            ),
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              search.value = value.trim();
            },
          ).addPadding(horizontal: 21.0, bottom: 21.0),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: index,
              builder: (context, value, child) {
                return Column(
                  children: [
                    Row(
                      spacing: 12.0,
                      children: tabs.map((e) {
                        return GestureDetector(
                          onTap: () => index.value = e.index,
                          child: Container(
                            width: 82.0,
                            decoration: BoxDecoration(
                              color: e.index == value
                                  ? context.scheme.primary
                                  : context.scheme.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            padding: const MPadding.set(vertical: 8.0),
                            child: Text(
                              e.title,
                              style: context.text.bodySmall!.copyWith(
                                color: e.index == value
                                    ? context.scheme.onPrimary
                                    : context.scheme.onSurface,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ).addPadding(bottom: 21.0),
                    Expanded(
                      child: [
                        AllIndicatorsTab(
                          onDone: widget.onDone,
                          search: search,
                        ),
                        FavoritesIndicatorsTab(
                          onDone: widget.onDone,
                          search: search,
                        ),
                        AppliedIndicatorsTab(
                          onDone: widget.onDone,
                          search: search,
                        )
                      ][value],
                    )
                  ],
                );
              },
            ).addPadding(horizontal: 21.0),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    index.dispose();
    search.dispose();
    super.dispose();
  }
}

class TabItem {
  final String title;
  final int index;

  TabItem({required this.title, required this.index});
}
