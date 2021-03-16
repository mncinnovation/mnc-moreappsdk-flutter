import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../data/constant/constant.dart';

class MncAppsInAppWebview extends StatefulWidget {
  final String? url;
  const MncAppsInAppWebview({Key? key, this.url}) : super(key: key);
  @override
  _MncAppsInAppWebviewState createState() => _MncAppsInAppWebviewState();
}

class _MncAppsInAppWebviewState extends State<MncAppsInAppWebview> {
  bool loading = true;
  bool isLight = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (url) async {
                await Future.delayed(Duration(seconds: 1));
                setState(() {
                  loading = false;
                });
              },
              onPageStarted: (url) {
                setState(() {
                  loading = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
