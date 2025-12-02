import 'package:example/core/consts/exports.dart';

class SlugWidget extends StatelessWidget {
  final Color? color;
  final double height;
  const SlugWidget({super.key, this.color, this.height = 38.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 2.0,
      decoration: BoxDecoration(
        color: color ?? context.colorScheme.tertiary,
        borderRadius: MBorderRadius.set(all: 12.0),
      ),
      margin: MPadding.set(end: 10.0),
    );
  }
}
