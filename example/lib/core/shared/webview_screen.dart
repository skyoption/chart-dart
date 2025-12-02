import 'package:auto_route/auto_route.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/jsons.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

@RoutePage()
class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final Widget? suffix;
  final Function(String url, BuildContext context) onNavigationRequest;
  final Function? onFinish;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.title,
    required this.onNavigationRequest,
    this.suffix,
    this.onFinish,
  });

  @override
  State<WebViewScreen> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewScreen> {
  late WebViewController controller;

  @override
  void initState() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    controller = controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..clearCache()
      ..clearLocalStorage()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            loading = progress < 100;
            setState(() {});
          },
          onPageStarted: (String url) {
            kPrint(url);
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            kPrint(request.url);
            widget.onNavigationRequest(request.url, context);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return ResponsiveScaledBox(
      width: ResponsiveValue<double>(
        context,
        conditionalValues: [const Condition.equals(name: MOBILE, value: 390)],
      ).value,
      child: BouncingScrollWrapper.builder(
        context,
        Scaffold(
          backgroundColor: context.colorScheme.surface,
          appBar: PreferredSize(
            preferredSize: Size(width, 50.0),
            child: SafeArea(
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: context.colorScheme.onSurface,
                      size: 28.0,
                    ).addAction(
                      onGesture: () async {
                        if (await controller.canGoBack()) {
                          controller.goBack();
                        } else {
                          AutoRouterX(context).maybePop();
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: MText(
                      text: widget.title,
                      size: FoontSize.font16,
                      weight: FontWeight.w600,
                      color: context.colorScheme.onSurface,
                      maxLines: 1,
                    ).addPadding(start: 32.0),
                  ),
                  if (widget.suffix != null)
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: widget.suffix,
                    ),
                ],
              ).addPadding(vertical: 12.0, horizontal: 21.0),
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: Stack(
              fit: StackFit.expand,
              children: [
                WebViewWidget(controller: controller),
                if (loading)
                  Align(
                    alignment: Alignment.center,
                    child: const MLottieImage(
                      name: Jsons.loading,
                      width: 100,
                      height: 60,
                      fit: BoxFit.fitHeight,
                    ).addPadding(bottom: 50.0),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.onFinish != null) {
      widget.onFinish!();
    }
    super.dispose();
  }
}
