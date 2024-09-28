import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MSvg extends StatelessWidget {
  final String? name;
  final String? path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final Key? mkey;
  final AlignmentGeometry alignment;

  const MSvg({
    Key? key,
    this.mkey,
    this.name,
    this.path,
    this.height = 25,
    this.width = 25,
    this.fit = BoxFit.contain,
    this.color,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path ?? "assets/svgs/$name.svg",
      width: width,
      height: height,
      fit: fit,
      color: color,
      key: mkey,
    );
  }
}