import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'package:mncapps/src/data/interface/libinterface.dart';
import 'package:mncapps/src/data/model/cachingstrategy.dart';

import '../data/interface/mncappsdatainterface.dart';
import '../data/model/appsmodel.dart';
import '../data/model/layoutmodel.dart';
import 'mncappsitem.dart';

/// Use this widget if you dont want to use app at all
class MNCAppsBody extends StatefulWidget {
  final String userID;
  final CachingStrategy? cachingStrategy;
  const MNCAppsBody({
    Key? key,
    required this.userID,
    this.cachingStrategy,
  }) : super(key: key);
  @override
  _MNCAppsBodyState createState() => _MNCAppsBodyState();
}

class _MNCAppsBodyState extends State<MNCAppsBody> {
  List<AppsModel>? items = [];
  LayoutModel? layout;
  MNCAppsDataInterface _dataInterface = MNCAppsDataInterface();
  LibInterface libInterface = LibInterface();

  String? error;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    print("Opening MNC Apps");
    libInterface.currentUserID = widget.userID;
    libInterface.cachingStrategy = widget.cachingStrategy ?? CachingStrategy.None;
    PackageInfo info = await PackageInfo.fromPlatform();
    libInterface.packageName = info.packageName;
    getData(libInterface);
  }

  getData(LibInterface libInterface) async {
    try {
      final data = await _dataInterface.getDataRepo(libInterface);
      print(data?.toJson() ?? "JSON Null");
      items = data!.items;
      layout = data.layoutModel;
    } catch (e) {
      debugPrint(e.toString());
      error = e.toString();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return _ErrorWidget(
        cause: error,
        libInterface: libInterface,
      );
    }
    if (items?.isEmpty ?? true) {
      return Container();
    }

    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth > 500) {
        return GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            crossAxisSpacing: 8,
          ),
          padding: EdgeInsets.all(16),
          itemCount: items!.length,
          itemBuilder: (context, i) {
            return MoreAppsItem(
              data: items![i],
              layoutModel: layout,
            );
          },
        );
      }
      return ListView.builder(
          itemCount: items!.length,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, i) {
            return MoreAppsItem(
              data: items![i],
              layoutModel: layout,
            );
          });
    });
  }
}

class _ErrorWidget extends StatelessWidget {
  final String? cause;
  final LibInterface? libInterface;
  const _ErrorWidget({
    Key? key,
    this.cause,
    this.libInterface,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Colors.red,
            ),
            SizedBox(height: 8),
            Text(
              'Error Getting data ${kDebugMode ? cause ?? "" : ""}',
              style: Theme.of(context).textTheme.headline6,
            ),
            if (kDebugMode)
              Column(
                children: <Widget>[
                  Text(libInterface?.currentUserID ?? ""),
                  Text(libInterface?.packageName ?? ""),
                ],
              ),
            Text(
              'Try Again later',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
