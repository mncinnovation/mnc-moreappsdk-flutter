import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mncapps/data/constant/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebview extends StatefulWidget {
  final String url;
  const InAppWebview({Key key, this.url}) : super(key: key);
  @override
  _InAppWebviewState createState() => _InAppWebviewState();
}

class _InAppWebviewState extends State<InAppWebview> {
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
