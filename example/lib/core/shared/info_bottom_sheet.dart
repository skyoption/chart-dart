import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/slug_widget.dart';
import 'package:example/core/shared/top_bottom_sheet_widget.dart';

class InfoBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final bool showSlug, showTitleDivider;
  const InfoBottomSheet({
    super.key,
    required this.title,
    required this.description,
    this.showSlug = true,
    this.showTitleDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopBottomSheetWidget(),
        MText(
          text: title,
          color: context.colorScheme.onSurface,
          size: FoontSize.font18,
          weight: FontWeight.w400,
        ).addPadding(bottom: showTitleDivider ? 15.0 : 30, horizontal: 21.0),
        if (showTitleDivider)
          MDividerItemWidget(
            color: context.colorScheme.outline,
          ).addPadding(bottom: 15),
        Row(
          children: [
            if (showSlug) SlugWidget(),
            Expanded(
              child: MText(
                text: description,
                color: context.colorScheme.onSurface,
                size: FoontSize.font16,
                weight: FontWeight.w400,
              ),
            ),
          ],
        ).addPadding(bottom: 40.0, horizontal: 16.0),
      ],
    );
  }
}

showInfoBottomSheet({
  required BuildContext context,
  required String title,
  required String description,
  bool showSlug = true,
  bool showTitleDivider = true,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: InfoBottomSheet(
      title: title,
      description: description,
      showSlug: showSlug,
      showTitleDivider: showTitleDivider,
    ),
  );
}
