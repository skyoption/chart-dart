import 'package:candle_chart/functions/widgets/object_item_widget.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/material.dart';

class ChartPropertiesScreen extends StatefulWidget {
  static const id = 'ChartPropertiesScreen';
  final bool volHidden;
  final MainState mainState;
  final SecondaryState? secondaryStateLi;

  final Function(
          bool volHidden, MainState mainState, SecondaryState? secondaryState)
      setMode;

  const ChartPropertiesScreen({
    super.key,
    required this.setMode,
    required this.volHidden,
    required this.mainState,
    required this.secondaryStateLi,
  });

  @override
  State<ChartPropertiesScreen> createState() => _ChartPropertiesScreenState();
}

class _ChartPropertiesScreenState extends State<ChartPropertiesScreen> {
  late bool _volHidden = widget.volHidden;
  late MainState _mainState = widget.mainState;
  late SecondaryState? _secondaryStateLi = widget.secondaryStateLi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 12.0,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 21.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Chart Properties',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(context, 'VOL'),
            buildVolButton(),
            _buildTitle(context, 'Main State'),
            buildMainButtons(),
            _buildTitle(context, 'Secondary State'),
            buildSecondButtons(),
            const SizedBox(height: 30),
            // if (_bids != null && _asks != null)
            //   Container(
            //     color: Colors.white,
            //     height: 320,
            //     width: double.infinity,
            //     child: DepthChart(
            //       _bids!,
            //       _asks!,
            //       chartColors,
            //     ),
            //   )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 12, 15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              // color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget buildVolButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: _buildButton(
            context: context,
            title: 'VOL',
            isActive: !_volHidden,
            onPress: () {
              _volHidden = !_volHidden;
              setState(() {});
              widget.setMode(_volHidden, _mainState, _secondaryStateLi);
            }),
      ),
    );
  }

  Widget buildMainButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 10,
        runSpacing: 10,
        children: MainState.values.map((e) {
          return _buildButton(
            context: context,
            title: e.name,
            isActive: _mainState == e,
            onPress: () {
              _mainState = e;
              widget.setMode(_volHidden, _mainState, _secondaryStateLi);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget buildSecondButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 10,
        runSpacing: 5,
        children: SecondaryState.values.map((e) {
          bool isActive = _secondaryStateLi == e;
          return _buildButton(
            context: context,
            title: e.name,
            isActive: isActive,
            onPress: () {
              _secondaryStateLi = e;
              widget.setMode(_volHidden, _mainState, _secondaryStateLi);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String title,
    required isActive,
    required Function onPress,
  }) {
    late Color? bgColor, txtColor;
    if (isActive) {
      bgColor = Theme.of(context).primaryColor.withOpacity(.15);
      txtColor = Theme.of(context).primaryColor;
    } else {
      bgColor = Colors.transparent;
      txtColor =
          Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.75);
    }
    return InkWell(
      onTap: () {
        onPress();
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: const BoxConstraints(minWidth: 60),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: txtColor,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
