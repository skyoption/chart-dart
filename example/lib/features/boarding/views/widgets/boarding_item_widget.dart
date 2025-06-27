import 'package:example/core/consts/exports.dart';

class BoardingItemWidget extends StatelessWidget {
  final Boarding item;

  const BoardingItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: MAssetImage(
            name: item.icon,
            height: context.height * 0.3,
            width: context.width * 0.76,
            fit: BoxFit.fitHeight,
          ),
        ).addPadding(bottom: 30.0),
        MText(
          text: item.title,
          size: FoontSize.font23,
          align: TextAlign.start,
          weight: FontWeight.w600,
        ).addPadding(
          bottom: 16.0,
          horizontal: 50.0,
        ),
        MText(
          text: item.description,
          size: FoontSize.font19,
          color: Coolors.black,
          align: TextAlign.start,
          maxLines: 100,
          maxWidth: context.width * 0.6,
        ).addPadding(horizontal: 50.0),
      ],
    );
  }
}

class Boarding {
  final String title, description, icon;

  Boarding({
    required this.icon,
    required this.title,
    required this.description,
  });
}
