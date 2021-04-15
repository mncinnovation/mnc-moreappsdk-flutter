import 'package:flutter/material.dart';
import 'package:mncapps/src/data/model/cachingstrategy.dart';

import '../data/constant/constant.dart';
import 'mncappsbody.dart';

/// Use fullscreen mncapps
class MNCAppsScreen extends StatefulWidget {
  final CachingStrategy? cachingStrategy;
  final String userID;

  const MNCAppsScreen({
    Key? key,
    this.cachingStrategy,
    required this.userID,
  }) : super(key: key);

  @override
  _MNCAppsScreenState createState() => _MNCAppsScreenState();
}

class _MNCAppsScreenState extends State<MNCAppsScreen> {
  bool isLight = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: isLight ? Colors.white : Colors.grey[900],
        brightness: isLight ? Brightness.light : Brightness.dark,
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0,
            iconTheme:
                IconThemeData(color: isLight ? Colors.black : Colors.white),
            title: Image.network(Constant.mnclogotext,
                width: 100, color: isLight ? Colors.black : Colors.white),
          ),
          body: MNCAppsBody(
            userID: widget.userID,
            cachingStrategy: widget.cachingStrategy,
          ),
        );
      }),
    );
  }
}
