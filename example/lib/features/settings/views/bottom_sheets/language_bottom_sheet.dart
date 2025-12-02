import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/option_item_widget.dart';
import 'package:example/core/framework/app_cubit.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({
    super.key,
  });

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late final ValueNotifier<int> _selectedIndex;
  late final AppCubit _appCubit;

  @override
  void initState() {
    _appCubit = context.read<AppCubit>();
    _selectedIndex = ValueNotifier(_appCubit.isArSelected.value ? 1 : 0);
    super.initState();
  }

  @override
  void dispose() {
    _selectedIndex.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (context, value, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: MText(
                  text: context.tr.language,
                  color: context.colorScheme.onSurface,
                  weight: FontWeight.w600,
                  size: FoontSize.font20,
                ).addPadding(bottom: 30.0),
              ),
              OptionItemWidget(
                title: context.tr.english,
                isSelected: value == 0,
                onTap: () {
                  _selectedIndex.value = 0;
                  _appCubit.changeLang('en');
                  AutoRouterX(context).pop();
                },
              ),
              OptionItemWidget(
                title: context.tr.arabic,
                isSelected: value == 1,
                onTap: () {
                  _selectedIndex.value = 1;
                  _appCubit.changeLang('ar');
                  AutoRouterX(context).pop();
                },
              ),
            ],
          ).addPadding(bottom: 30.0);
        });
  }
}

void showLanguageBottomSheet({
  required BuildContext context,
}) {
  showMBottomSheet(
    context: context,
    borderRadius: MBorderRadius.set(all: 12.0),
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: const LanguageBottomSheet(),
  );
}
