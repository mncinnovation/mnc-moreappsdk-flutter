library mncapps;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mncapps/data/interface/libinterface.dart';
import 'package:mncapps/data/model/cachingstrategy.dart';
import 'package:package_info/package_info.dart';

export 'package:mncapps/widget/mncappsscreen.dart';
export 'package:mncapps/widget/mncappsbody.dart';

class _MNCapps {
  _MNCapps._();
  static final _MNCapps _instance = _MNCapps._();
  factory _MNCapps() {
    return _instance;
  }

  init({@required String userID, CachingStrategy cachingStrategy}) async {
    assert(userID is String);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    LibInterface.currentUserID = userID;
    LibInterface.packageName = packageInfo.packageName;
    LibInterface.cachingStrategy = cachingStrategy ?? CachingStrategy.None;
  }
}

// ignore: non_constant_identifier_names
final MNCapps = _MNCapps();
