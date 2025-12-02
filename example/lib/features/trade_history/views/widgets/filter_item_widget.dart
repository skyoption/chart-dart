// ignore_for_file: must_be_immutable

import 'package:example/core/consts/exports.dart';

class FilterItemWidget extends StatelessWidget {
  final bool check;
  final String title;
  final Function onTap;

  const FilterItemWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: check
              ? context.colorScheme.surfaceBright.withValues(alpha: 0.3)
              : Coolors.transparent,
          padding: const MPadding.set(horizontal: 21.0, vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MText(
                text: title,
                size: FoontSize.font16,
                weight: FontWeight.w400,
                color: context.colorScheme.onSurface,
              ),
              if (check)
                Icon(
                  Icons.check,
                  color: context.colorScheme.onSurface,
                  size: 28.0,
                )
              else
                const SizedBox(height: 32.0)
            ],
          ),
        ),
        if (!check)
          MDividerItemWidget(
            color: context.colorScheme.outline,
            padding: const MPadding.set(),
          ),
      ],
    ).addAction(
      onGesture: () {
        onTap();
      },
    );
  }
}
