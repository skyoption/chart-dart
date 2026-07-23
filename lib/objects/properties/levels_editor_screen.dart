import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

/// Ellipsized preview of an object's effective levels plus a chevron, for use
/// as the trailing widget of a tappable "Levels" row.
class LevelsPreview extends StatelessWidget {
  final ObjectEntity object;
  final List<double> defaults;

  const LevelsPreview({
    super.key,
    required this.object,
    required this.defaults,
  });

  @override
  Widget build(BuildContext context) {
    final text =
        effectiveLevels(object, defaults).map((e) => e.toString()).join(', ');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.withAlpha(140),
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Icon(
            Icons.arrow_forward_ios_sharp,
            size: 16.0,
            color: Colors.grey.withAlpha(140),
          ),
        ),
      ],
    );
  }
}

/// Editor for a Fibonacci object's levels: edit values, add and delete levels.
/// On confirm it writes the working list back to [object].levels.
class LevelsEditorScreen extends StatefulWidget {
  static const id = 'LevelsEditorScreen';
  final ObjectEntity object;
  final List<double> defaults;

  const LevelsEditorScreen({
    super.key,
    required this.object,
    required this.defaults,
  });

  @override
  State<LevelsEditorScreen> createState() => _LevelsEditorScreenState();
}

class _LevelsEditorScreenState extends State<LevelsEditorScreen> {
  late final List<TextEditingController> controllers;

  @override
  void initState() {
    final current = widget.object.levels.isNotEmpty
        ? widget.object.levels
        : widget.defaults;
    controllers =
        current.map((e) => TextEditingController(text: _fmt(e))).toList();
    super.initState();
  }

  String _fmt(double v) {
    final s = v.toStringAsFixed(3);
    return s;
  }

  void _addLevel() {
    setState(() => controllers.add(TextEditingController(text: '0.000')));
  }

  void _removeAt(int index) {
    setState(() {
      controllers[index].dispose();
      controllers.removeAt(index);
    });
  }

  void _save() {
    final result = <double>[];
    for (final c in controllers) {
      final v = double.tryParse(c.text.trim());
      if (v != null) result.add(v);
    }
    widget.object.levels = result;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.levels,
            onBack: () => Navigator.of(context).pop(),
            onDone: _save,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: MPadding.set(vertical: 8.0),
              itemCount: controllers.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ObjectKey(controllers[index]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _removeAt(index),
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red.withAlpha(40),
                    padding: MPadding.set(horizontal: 21.0),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  child: Container(
                    color: context.scheme.surface,
                    padding: MPadding.set(horizontal: 21.0, vertical: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 14.0,
                          height: 14.0,
                          margin: MPadding.set(end: 14.0),
                          decoration: BoxDecoration(
                            color: fibonacciLevelColor(index),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          '${context.tr.level} ${index + 1}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 90.0,
                          child: TextField(
                            controller: controllers[index],
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.blueAccent),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: '0.000',
                            ),
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            Icons.remove_circle_outline,
                            size: 20.0,
                            color: Colors.red.withAlpha(180),
                          ),
                          onPressed: () => _removeAt(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: MPadding.set(horizontal: 21.0, vertical: 12.0),
              child: GestureDetector(
                onTap: _addLevel,
                child: Container(
                  width: double.infinity,
                  padding: MPadding.set(vertical: 14.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withAlpha(30),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add,
                          size: 20.0, color: Colors.blueAccent),
                      const SizedBox(width: 8.0),
                      Text(
                        context.tr.addLevel,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }
}
