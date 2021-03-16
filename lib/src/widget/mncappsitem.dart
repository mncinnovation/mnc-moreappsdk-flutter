import 'package:flutter/material.dart';
import '../data/model/appsmodel.dart' show AppsModel;
import '../data/model/layoutmodel.dart' show LayoutModel;
import '../utils/buttonutils.dart' show ButtonUtils;
import '../utils/hexcolor.dart' show HexColor;
import '../utils/layoututils.dart';

class MoreAppsItem extends StatefulWidget {
  final AppsModel? data;
  final LayoutModel? layoutModel;
  MoreAppsItem({this.data, this.layoutModel});

  @override
  _MoreAppsItemState createState() => _MoreAppsItemState();
}

class _MoreAppsItemState extends State<MoreAppsItem> with ButtonUtils {
  bool installed = false;
  String butttonText = 'Open';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    installed = await getInstalledStatus(data: widget.data);
    butttonText = await getButtonLabel(data: widget.data!, installed: installed);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 3, top: 0.5, right: 3, bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey[850],
          borderRadius: widget.layoutModel?.cardRoundedSize?.getRoundSize() ?? BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light ? Colors.grey[200]! : Colors.black38,
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(widget.data!.image!),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.data?.appName ?? "Title",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light ? Colors.black87 : Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.data?.description?.id ?? "Desc",
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).brightness == Brightness.light ? Colors.grey[700] : Colors.grey[400],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(widget.layoutModel?.buttonColor != null ? HexColor.fromHex(widget.layoutModel!.buttonColor!) : Colors.blue),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: widget.layoutModel?.buttonRoundedSize?.getRoundSize() ?? BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                onPressed: () => openFunction(context: context, installed: installed, data: widget.data),
                child: Text(
                  butttonText,
                  maxLines: 1,
                  style: TextStyle(
                    color: HexColor.fromHex(widget.layoutModel?.buttonTextColor ?? "FFFFFF"),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
