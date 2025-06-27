import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/views/login_screen.dart';
import 'package:example/features/boarding/logic/boarding_cubit.dart';
import 'package:example/features/splash/views/widgets/gradient_scaffold.dart';
import 'package:example/injection/injectable.dart';

import 'widgets/boarding_item_widget.dart';

class BoardingScreen extends StatefulWidget {
  static const id = 'BoardingScreen';

  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<BoardingScreen>
    with SingleTickerProviderStateMixin {
  late final cubit = getIt<BoardingCubit>()
    ..setUp(TabController(length: 4, vsync: this));

  @override
  void initState() {
    getIt<SharedPreferences>().setBool(Constants.SLIDERSTATE, true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: cubit.tabController,
              children: cubit.boards.map((e) {
                return BoardingItemWidget(item: e);
              }).toList(),
            ),
          ),
          BlocProvider(
            create: (context) => cubit,
            child: FlowBuilder<BoardingCubit>(
              builder: (context, state, cubit) {
                return SizedBox(
                  height: 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MBouncingButton(
                        title: context.tr.skip,
                        color: Coolors.transparent,
                        textColor: context.colorScheme.scrim,
                        textSize: FoontSize.font20,
                        width: context.width * 0.24,
                        onTap: () {
                          context.pushNamed(LoginScreen.id);
                        },
                      ),
                      Row(
                        children: List.generate(
                          4,
                          (index) => Container(
                            height: 8.0,
                            width: 8.0,
                            margin: const MPadding.set(end: 6.0),
                            decoration: BoxDecoration(
                              borderRadius: MBorderRadius.set(all: 12.0),
                              color: cubit.index == index
                                  ? context.colorScheme.primary
                                  : context.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                      MBouncingButton(
                        onTap: () {
                          cubit.next(() {
                            context.pushNamed(LoginScreen.id);
                          });
                        },
                        title: context.tr.next,
                        width: context.width * 0.24,
                        borderRadius: 20.0,
                        height: 55.0,
                      )
                    ],
                  ),
                ).addPadding(bottom: 50.0, start: 12.0, end: 24.0);
              },
            ),
          ),
        ],
      ),
    );
  }

// @override
// void dispose() {
//   cubit.close();
//   super.dispose();
// }
}
