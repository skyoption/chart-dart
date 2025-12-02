import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/loading.dart';

class IbLoadingWidget extends StatelessWidget {
  final double? height;
  const IbLoadingWidget({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(10, (index) {
          return Loading.loadingSkeleton(
            padding: const MPadding.set(bottom: 12.0),
            borderRadius: MBorderRadius.set(all: 8.0),
            height: height ?? 90.0,
            width: double.infinity,
          );
        }),
      ),
    );
  }
}

class IbLoading2Widget extends StatelessWidget {
  const IbLoading2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(10, (index) {
          return Loading.loadingSkeleton(
            padding: const MPadding.set(bottom: 12.0),
            borderRadius: MBorderRadius.set(all: 12.0),
            height: context.height * 0.19,
            width: double.infinity,
          );
        }),
      ),
    );
  }
}
