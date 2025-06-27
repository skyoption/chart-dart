import 'package:example/core/consts/exports.dart';

class ContainerIconWidget extends StatelessWidget {
  final String icon;
  final Color color;
  final double size, containerSize, radius;

  const ContainerIconWidget({
    super.key,
    required this.color,
    required this.icon,
    this.size = 18.0,
    this.containerSize = 35.0,
    this.radius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: MBorderRadius.set(all: radius),
      ),
      width: containerSize,
      height: containerSize,
      padding: const MPadding.set(all: 8.0),
      margin: const MPadding.set(end: 6.0),
      alignment: Alignment.center,
      child: MSvg(
        name: icon,
        color: color,
        height: size,
        width: size,
      ),
    );
  }
}
