import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import '../widget/inappwebview.dart';
import '../data/model/appsmodel.dart';
import 'package:url_launcher/url_launcher.dart';

mixin ButtonUtils {
  Future<bool> getInstalledStatus({AppsModel? data}) async {
    if (Platform.isIOS) {
      String scheme = data!.ios!.scheme!;
      return await canLaunch(scheme);
    }
    if (Platform.isAndroid) {
      Uri playstoreURL = Uri.dataFromString(data!.android!.store!);
      String? id = playstoreURL.queryParameters['id'];
      final app = await DeviceApps.getApp(id ?? '');
      return app != null;
    }
    return false;
  }

  Future<String> getButtonLabel(
      {required AppsModel data, bool? installed}) async {
    if (data.open == 'web') return 'OPEN';
    return installed! ? "OPEN" : "INSTALL";
  }

  Future<void> openFunction(
      {BuildContext? context, AppsModel? data, bool? installed}) async {
    if (Platform.isAndroid) {
      if (data!.open == 'store') {
        launch(data.android!.store!);
        return;
      }
      if (data.open == 'web') {
        Navigator.push(
            context!,
            MaterialPageRoute(
                builder: (context) => MncAppsInAppWebview(url: data.webUrl)));
        return;
      }
      if (data.open == 'app') {
        if (installed!) {
          Uri playstoreURL = Uri.dataFromString(data.android!.store!);
          String id = playstoreURL.queryParameters['id']!;
          DeviceApps.openApp(id);
          return;
        }
        launch(data.android!.store!);
        return;
      }
    }

    if (Platform.isIOS) {
      if (data!.open == 'store') {
        launch(data.ios!.store!);
        return;
      }
      if (data.open == 'web') {
        Navigator.push(
            context!,
            MaterialPageRoute(
                builder: (context) => MncAppsInAppWebview(url: data.webUrl)));
        return;
      }
      if (data.open == 'app') {
        if (installed!) {
          launch(data.ios!.scheme!);
        }
        launch(data.ios!.store!);
        return;
      }
    }
  }
}
