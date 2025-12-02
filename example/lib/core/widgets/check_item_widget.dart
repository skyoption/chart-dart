import 'package:example/core/consts/exports.dart';

class CheckItemWidget extends StatefulWidget {
  final Function(bool value) onChange;
  final String title;
  final String? linkedTitle, completedTitle;
  final Function? onTap;

  const CheckItemWidget({
    super.key,
    required this.onChange,
    required this.title,
    this.linkedTitle,
    this.completedTitle,
    this.onTap,
  });

  @override
  State<CheckItemWidget> createState() => _CheckItemWidgetState();
}

class _CheckItemWidgetState extends State<CheckItemWidget> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: check
                ? context.colorScheme.primary
                : context.colorScheme.onSurface,
            borderRadius: MBorderRadius.set(all: 8.0),
            border: Border.all(
              color: check
                  ? context.colorScheme.primary
                  : context.colorScheme.outline,
            ),
          ),
          padding: const MPadding.set(all: 2.0),
          child: Icon(
            Icons.check,
            color: check
                ? context.colorScheme.onPrimary
                : context.colorScheme.onSurface,
          ),
        ).addAction(
          onGesture: () {
            setState(() {
              check = !check;
            });
            widget.onChange(check);
          },
        ).addPadding(end: 12.0),
        Expanded(
          child: Wrap(
            children: [
              MText(
                text: widget.title,
                size: FoontSize.font18,
                weight: FontWeight.w400,
              ).addPadding(end: 6.0, bottom: 4.0),
              Wrap(
                children: [
                  if (widget.linkedTitle != null)
                    MText(
                      text: widget.linkedTitle,
                      size: FoontSize.font18,
                      color: context.colorScheme.surfaceBright,
                      weight: FontWeight.w400,
                    ).addAction(onTap: widget.onTap),
                  if (widget.completedTitle != null)
                    MText(
                      text: widget.completedTitle,
                      size: FoontSize.font18,
                      weight: FontWeight.w400,
                    ).addPadding(start: 6.0),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
