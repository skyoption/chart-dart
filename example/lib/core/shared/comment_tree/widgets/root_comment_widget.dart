import 'package:example/core/consts/exports.dart';

import 'tree_theme_data.dart';

class RootCommentWidget extends StatelessWidget {
  final Widget content;
  final Size sizeRoot;

  const RootCommentWidget({
    super.key,
    required this.content,
    required this.sizeRoot,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RootPainter(
        sizeRoot,
        context.watch<TreeThemeData>().lineColor,
        context.watch<TreeThemeData>().lineWidth,
        Directionality.of(context),
      ),
      child: content,
    );
  }
}

class RootPainter extends CustomPainter {
  Size? avatar;
  late Paint _paint;
  Color? pathColor;
  double? strokeWidth;
  final TextDirection textDecoration;
  RootPainter(
      this.avatar, this.pathColor, this.strokeWidth, this.textDecoration) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (textDecoration == TextDirection.rtl) canvas.translate(size.width, 0);
    double dx = avatar!.width / 2;
    if (textDecoration == TextDirection.rtl) dx *= -1;
    canvas.drawLine(
      Offset(dx, avatar!.height),
      Offset(dx, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
