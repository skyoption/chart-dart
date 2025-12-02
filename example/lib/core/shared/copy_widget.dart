import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/mtoast.dart';

class CopyWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;

  const CopyWidget({
    super.key,
    required this.text,
    this.color,
    this.size = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return MSvg(
      name: Svgs.copy,
      color: color ?? context.colorScheme.onSurface,
      width: size,
      height: size,
    ).addAction(
      onGesture: () {
        Clipboard.setData(ClipboardData(text: text));
        MToast.showSuccess(message: context.tr.copiedToClipboard);
      },
    );
  }
}
