import 'dart:ui';

import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/main/logic/bottom_nav_cubit.dart';

import 'bottom_nav_item_widget.dart';

class BottomNavWidget extends StatefulWidget {
  final ValueChanged onChanged;
  final List<NavModel> items;

  const BottomNavWidget({
    super.key,
    required this.onChanged,
    required this.items,
  });

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget>
    with SingleTickerProviderStateMixin {
  late final BottomNavCubit cubit = context.read<BottomNavCubit>()
    ..init(AnimationController(vsync: this), context.width);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: FlowBuilder<BottomNavCubit>(
        builder: (context, state, cubit) {
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
                          color: context.colorScheme.surfaceContainer
                              .withAlpha(90),
                          borderRadius: MBorderRadius.set(top: 21.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.items.asMap().entries.map((item) {
                    return Expanded(
                      flex: cubit.index == item.key ? 6 : 5,
                      child: BottomNavItemWidget(
                        mKey: item.key,
                        active: cubit.index == item.key,
                        icon: item.value.icon,
                        title: item.value.name,
                      ).addAction(
                        onTap: () {
                          widget.onChanged(item.key);
                          cubit.moveTo(item.key);
                        },
                      ),
                    );
                  }).toList(),
                ).addPadding(horizontal: 12.0),
              ],
            ),
          );
        },
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
