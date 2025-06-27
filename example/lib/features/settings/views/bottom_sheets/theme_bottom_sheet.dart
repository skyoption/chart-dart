import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/app_cubit.dart';
import 'package:example/core/widgets/option_item_widget.dart';

class ChangeThemeSheet extends StatefulWidget {
  const ChangeThemeSheet({super.key});

  @override
  State<ChangeThemeSheet> createState() => _ChangeThemeSheetState();
}

class _ChangeThemeSheetState extends State<ChangeThemeSheet> {
  late final ValueNotifier<int> _selectedIndex;
  late final AppCubit _appCubit;
  @override
  void initState() {
    _appCubit = context.read<AppCubit>();
    _selectedIndex = ValueNotifier(_appCubit.appThemeMode.index);
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
      builder: (context, index, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: MText(
                text: context.tr.changeTheme,
                size: FoontSize.font18,
                weight: FontWeight.w500,
                color: context.colorScheme.scrim,
              ),
            ).addPadding(bottom: 30.0),
            OptionItemWidget(
              title: context.tr.light,
              icon: Svgs.changeThemeIcon,
              isSelected: index == 0,
              onTap: () {
                _selectedIndex.value = 0;
                _appCubit.changeThemeMode(0);
                context.pop();
              },
            ),
            OptionItemWidget(
              title: context.tr.dark,
              icon: Svgs.darkModeIcon,
              isSelected: index == 1,
              onTap: () {
                _selectedIndex.value = 1;
                _appCubit.changeThemeMode(1);
                context.pop();
              },
            ),
            OptionItemWidget(
              title: context.tr.defaultSystem,
              icon: Svgs.settings,
              isSelected: index == 2,
              onTap: () {
                _selectedIndex.value = 2;
                _appCubit.changeThemeMode(2);
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void showThemeBottomSheet({required BuildContext context}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    borderRadius: MBorderRadius.set(topStart: 24.0, topEnd: 24.0),
    padding: const MPadding.set(vertical: 30),
    backgorundColor: context.colorScheme.primaryContainer,
    bottomSheet: const ChangeThemeSheet(),
  );
}
