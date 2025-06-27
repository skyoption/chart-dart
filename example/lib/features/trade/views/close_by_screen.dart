import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/close_by_item_widget.dart';

class CloseByScreen extends StatefulWidget {
  static const id = 'CloseByScreen';

  const CloseByScreen({super.key});

  @override
  State<CloseByScreen> createState() => _CloseByScreenState();
}

class _CloseByScreenState extends State<CloseByScreen> {
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.08),
        child: SafeArea(
          child: Row(
            children: [
              Icon(
                Icons.clear,
                color: context.colorScheme.scrim,
                size: 30.0,
              ).addAction(
                padding: const MPadding.set(vertical: 21.0, end: 8.0),
                onGesture: () {
                  context.pop();
                },
              ),
              MText(
                text: context.tr.closeBy,
                color: Coolors.primaryColor,
                weight: FontWeight.w600,
                size: FoontSize.font18,
              ),
            ],
          ).addPadding(horizontal: 21.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MScroll(
              padding: const MPadding.set(horizontal: 21.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MText(
                    text: context.tr.mainPosition,
                    weight: FontWeight.w600,
                    size: FoontSize.font16,
                  ).addPadding(vertical: 15.0),
                  CloseByItemWidget(
                    selected: true,
                    onTap: () {},
                  ),
                  MText(
                    text: context.tr.closeByMainPosition,
                    weight: FontWeight.w600,
                    size: FoontSize.font16,
                  ).addPadding(vertical: 15.0),
                  Column(
                    children: List.generate(
                      5,
                      (index) => CloseByItemWidget(
                        selected: index == 0,
                        onTap: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: MBouncingButton(
              title: context.tr.closeBy,
              height: 50.0,
              borderRadius: 8.0,
              color: Coolors.red,
              onTap: () {},
            ).addPadding(top: 30.0, bottom: 40.0, horizontal: 21.0),
          ),
        ],
      ),
    );
  }
}
