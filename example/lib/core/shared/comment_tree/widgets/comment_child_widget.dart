import 'package:example/core/consts/exports.dart';

import 'tree_theme_data.dart';

class CommentChildWidget extends StatelessWidget {
  final Widget? content;
  final bool? isLast;
  final Size sizeRoot, sizeChild;

  const CommentChildWidget({
    super.key,
    required this.isLast,
    required this.content,
    required this.sizeRoot,
    required this.sizeChild,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final EdgeInsets padding = EdgeInsets.only(
        left: isRTL ? 0 : sizeRoot!.width * 0.75,
        bottom: 8,
        top: 8,
        right: isRTL ? sizeRoot!.width * 0.75 : 0);

    return CustomPaint(
      painter: _Painter(
        isLast: isLast!,
        padding: padding,
        textDirection: Directionality.of(context),
        sizeRoot: sizeRoot,
        sizeChild: sizeChild,
        pathColor: context.watch<TreeThemeData>().lineColor,
        strokeWidth: context.watch<TreeThemeData>().lineWidth,
      ),
      child: Container(padding: padding, child: content!),
    );
  }
}

class _Painter extends CustomPainter {
  bool isLast = false;

  EdgeInsets? padding;
  final TextDirection textDirection;
  Size? sizeRoot;
  Size? sizeChild;
  Color? pathColor;
  double? strokeWidth;

  _Painter({
    required this.isLast,
    required this.textDirection,
    this.padding,
    this.sizeRoot,
    this.sizeChild,
    this.pathColor,
    this.strokeWidth,
  }) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    if (textDirection == TextDirection.rtl) canvas.translate(size.width, 0);
    double rootDx = sizeRoot!.width / 2;
    if (textDirection == TextDirection.rtl) rootDx *= -1;
    path.moveTo(rootDx, 0);
    path.cubicTo(
      rootDx,
      0,
      rootDx,
      padding!.top + sizeChild!.height / 2,
      rootDx * 2,
      padding!.top + sizeChild!.height / 2,
    );
    canvas.drawPath(path, _paint);

    if (!isLast) {
      canvas.drawLine(
        Offset(rootDx, 0),
        Offset(rootDx, size.height),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
