import 'dart:ui';

import 'package:example/core/consts/exports.dart';

import 'bottom_nav_item_widget.dart';

class BottomNavWidget extends StatelessWidget {
  final ValueChanged onChanged;
  final List<NavModel> items;
  final int index;

  const BottomNavWidget({
    super.key,
    required this.onChanged,
    required this.items,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95.0,
      // padding: MPadding.set(bottom: Platform.isIOS ? 12.0 : 0.0),
      width: double.infinity,
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.centerStart,
        children: [
          ClipRRect(
            child: SizedBox(
              height: 95.0,
              child: BackdropFilter(
                blendMode: BlendMode.srcOver,
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  height: 95.0,
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainer.withAlpha(90),
                    borderRadius: MBorderRadius.set(top: 21.0),
                  ),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items.asMap().entries.map((item) {
              return Expanded(
                flex: index == item.key ? 6 : 5,
                child: BottomNavItemWidget(
                  mKey: item.key,
                  active: index == item.key,
                  icon: item.value.icon,
                  title: item.value.name,
                ).addAction(
                  onTap: () => onChanged(item.key),
                ),
              );
            }).toList(),
          ).addPadding(horizontal: 12.0),
        ],
      ),
    );
  }
}

class NavModel {
  final String icon, name, key;

  const NavModel({
    required this.name,
    required this.icon,
    required this.key,
  });
}
