import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({super.key});

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MScroll(
        axis: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
            borderRadius: MBorderRadius.set(all: 10.0),
          ),
          margin: const MPadding.set(horizontal: 21.0),
          padding: const MPadding.set(horizontal: 12.0, vertical: 7.0),
          child: FlowBuilder<QuotesCubit>(
            builder: (context, state, cubit) {
              final items = [
                context.tr.all,
                context.tr.favorites,
                ...cubit.categories,
              ];
              return Row(
                children: items.map((item) {
                  return InkWell(
                    onTap: () {
                      cubit.setType(item);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: cubit.type == item
                            ? context.colorScheme.primary
                            : Colors.transparent,
                        borderRadius: MBorderRadius.set(all: 8.0),
                      ),
                      padding: const MPadding.set(
                        horizontal: 21.0,
                        vertical: 6.0,
                      ),
                      child: MText(
                        text: item,
                        color: cubit.type == item
                            ? AppColors.white
                            : context.colorScheme.onSurface,
                        size: FoontSize.font16,
                        weight: cubit.type == item
                            ? FontWeight.w500
                            : FontWeight.w300,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
