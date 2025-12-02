// import 'package:example/core/consts/exports.dart';
//
// class AmountInput extends StatefulWidget {
//   final Function(double amount) onChange;
//   final double initialValue, minValue, maxValue, step;
//   const AmountInput({
//     super.key,
//     required this.onChange,
//     this.initialValue = 0.0,
//     this.minValue = 0.0,
//     this.maxValue = double.infinity,
//     this.step = 1.0,
//   });
//
//   @override
//   State<AmountInput> createState() => _AmountInputState();
// }
//
// class _AmountInputState extends State<AmountInput> {
//   late final ValueNotifier<double> _amountNotifier;
//
//   @override
//   void initState() {
//     super.initState();
//     _amountNotifier = ValueNotifier(widget.initialValue);
//     _amountNotifier.addListener(_handleChange);
//   }
//
//   void _handleChange() {
//     widget.onChange(_amountNotifier.value);
//   }
//
//   void _increment() {
//     if (_amountNotifier.value + widget.step <= widget.maxValue) {
//       _amountNotifier.value += widget.step;
//     }
//   }
//
//   void _decrement() {
//     if (_amountNotifier.value - widget.step >= widget.minValue) {
//       _amountNotifier.value -= widget.step;
//     }
//   }
//
//   @override
//   void dispose() {
//     _amountNotifier.removeListener(_handleChange);
//     _amountNotifier.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         MText(
//           text: context.tr.amount,
//           style: TextStyle(
//             color: context.colorScheme.onSurface,
//             fontSize: FoontSize.font17,
//             fontWeight: FontWeight.w500,
//           ),
//         ).addPadding(left: 4.0, bottom: 8.0),
//         Container(
//           padding: MPadding.set(vertical: 10, horizontal: 16),
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: context.colorScheme.outline, width: 1),
//           ),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.remove, color: context.colorScheme.primary),
//                 onPressed: _decrement,
//               ),
//               Expanded(
//                 child: ValueListenableBuilder<double>(
//                   valueListenable: _amountNotifier,
//                   builder: (context, value, child) {
//                     return AnimatedSwitcher(
//                       duration: Duration(milliseconds: 200),
//                       child: MText(
//                         key: ValueKey(value),
//                         text: value.toStringAsFixed(2).padLeft(8, '0'),
//                         align: TextAlign.center,
//                         size: FoontSize.font15,
//                         weight: FontWeight.w400,
//                         color: context.colorScheme.onSurface,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.add, color: context.colorScheme.primary),
//                 onPressed: _increment,
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
