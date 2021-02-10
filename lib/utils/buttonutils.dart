import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:mncapps/data/model/appsmodel.dart';
import 'package:mncapps/widget/inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

mixin ButtonUtils {
  Future<bool> getInstalledStatus({AppsModel data}) async {
    if (Platform.isIOS) {
      String scheme = data.ios.scheme;
      return await canLaunch(scheme);
    }
    if (Platform.isAndroid) {
      Uri playstoreURL = Uri.dataFromString(data.android.store);
      String id = playstoreURL.queryParameters['id'];
      final app = await DeviceApps.getApp(id ?? '');
      return app != null;
    }
    return false;
  }

  Future<String> getButtonLabel({AppsModel data, bool installed}) async {
    if (data.open == 'web') return 'OPEN';
    return installed ? "OPEN" : "INSTALL";
  }

  Future<void> openFunction({BuildContext context, AppsModel data, bool installed}) async {
    if (Platform.isAndroid) {
      if (data.open == 'store') return launch(data.android.store);
      if (data.open == 'web') {
        return Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebview(url: data.webUrl)));
      }
      if (data.open == 'app') {
        if (installed) {
          Uri playstoreURL = Uri.dataFromString(data.android.store);
          String id = playstoreURL.queryParameters['id'];
          DeviceApps.openApp(id);
          return;
        }
        return launch(data.android.store);
      }
    }

    if (Platform.isIOS) {
      if (data.open == 'store') return launch(data.ios.store);
      if (data.open == 'web') {
        return Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebview(url: data.webUrl)));
      }
      if (data.open == 'app') {
        if (installed) {
          launch(data.ios.scheme);
        }
        return launch(data.ios.store);
      }
    }
  }
}
