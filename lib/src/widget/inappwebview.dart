import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../data/constant/constant.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

class MncAppsInAppWebview extends StatefulWidget {
  final String? url;
  const MncAppsInAppWebview({Key? key, this.url}) : super(key: key);
  @override
  _MncAppsInAppWebviewState createState() => _MncAppsInAppWebviewState();
}

class _MncAppsInAppWebviewState extends State<MncAppsInAppWebview> {
  bool loading = true;
  bool isLight = true;
  late final WebViewController _controller;
  PlatformWebViewControllerCreationParams params =
      const PlatformWebViewControllerCreationParams();

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (url) async {
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          loading = false;
        });
      }, onPageStarted: (url) {
        setState(() {
          loading = true;
        });
      }))
      ..loadRequest(Uri.parse(widget.url ?? ''));
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Image.network(
          Constant.mnclogotext,
          width: 100,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: isLight ? Colors.black : Colors.white),
      ),
      body: Column(
        children: [
          if (loading) LinearProgressIndicator(),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}
