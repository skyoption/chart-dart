import 'package:example/core/consts/exports.dart';

class TopBottomSheetWidget extends StatelessWidget {
  const TopBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200.0,
        height: 6.0,
        decoration: BoxDecoration(
          color: context.colorScheme.onSurface,
          borderRadius: MBorderRadius.set(all: 12.0),
        ),
      ),
    ).addPadding(bottom: 21.0);
  }
}
