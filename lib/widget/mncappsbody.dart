import 'package:flutter/material.dart';
import 'package:mncapps/data/interface/mncappsdatainterface.dart';
import 'package:mncapps/data/model/appsmodel.dart';
import 'package:mncapps/data/model/layoutmodel.dart';
import 'package:mncapps/widget/mncappsitem.dart';

class MNCAppsBody extends StatefulWidget {
  @override
  _MNCAppsBodyState createState() => _MNCAppsBodyState();
}

class _MNCAppsBodyState extends State<MNCAppsBody> {
  List<AppsModel> items = [];
  LayoutModel layout;
  MNCAppsDataInterface _dataInterface = MNCAppsDataInterface();
  String error;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      final data = await _dataInterface.getDataRepo();
      setState(() {
        items = data.items;
        layout = data.layoutModel;
      });
    } catch (e) {
      debugPrint(e.toString());
      error = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (items == null) return _ErrorWidget();

    if (items.isEmpty) {
      return Container();
    }

    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth > 400) {
        return GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            crossAxisSpacing: 8,
          ),
          padding: EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, i) {
            return MoreAppsItem(
              data: items[i],
              layoutModel: layout,
            );
          },
        );
      }
      return ListView.builder(
          itemCount: items.length,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, i) {
            return MoreAppsItem(
              data: items[i],
              layoutModel: layout,
            );
          });
    });
  }
}

class _ErrorWidget extends StatelessWidget {
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
              'Error Getting data',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Try Again Data',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
