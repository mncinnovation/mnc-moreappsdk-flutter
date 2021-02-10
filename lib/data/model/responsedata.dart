import 'dart:convert';

import 'package:mncapps/data/model/appsmodel.dart';
import 'package:mncapps/data/model/layoutmodel.dart';

class ResponseData {
  List<AppsModel> items;
  LayoutModel layoutModel;
  ResponseData({
    this.items,
    this.layoutModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'items': items?.map((x) => x?.toMap())?.toList(),
      'layout': layoutModel?.toMap(),
    };
  }

  factory ResponseData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResponseData(
      items: List<AppsModel>.from(map['items']?.map((x) => AppsModel.fromMap(x))),
      layoutModel: LayoutModel.fromMap(map['layout']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseData.fromJson(String source) => ResponseData.fromMap(json.decode(source));
}
