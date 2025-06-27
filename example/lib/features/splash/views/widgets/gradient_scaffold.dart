import 'dart:ui';

import 'package:example/core/consts/exports.dart';

class GradientScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final Widget body;

  const GradientScaffold({
    Key? key,
    required this.body,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Scaffold(
      backgroundColor: backgroundColor ?? Coolors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        width: width * 0.8,
                        height: width * 0.8,
                        margin: MPadding.set(top: height * 0.02),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd,
                            colors: [
                              Color(0xff7933AC),
                              Color(0xff570099),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        width: width * 0.8,
                        height: width * 0.8,
                        margin: MPadding.set(bottom: height * 0.02),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd,
                            colors: [
                              Color(0xff9B66C2),
                              Color(0xff7933AC),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                ],
              ),
            ),
            PositionedDirectional(
              start: 0.0,
              end: 0.0,
              top: 0.0,
              bottom: 0.0,
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
