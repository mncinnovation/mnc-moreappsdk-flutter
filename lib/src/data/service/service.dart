import 'dart:io';

import '../model/responsedata.dart';
import 'package:http/http.dart' as http;

mixin Service {
  Future<ResponseData> getDataNetwork(String? userID, String? packageName) async {
    try {
      if (userID == null) throw '[MNCAPPS] User ID Empty';
      if (packageName == null) throw '[MNCAPPS] packageName Empty';
      String platformType = 'android';
      if (Platform.isIOS) platformType = 'ios';
      if (Platform.isMacOS) platformType = 'ios';

      final url = 'https://firebasestorage.googleapis.com/v0/b/mnc-apps-libs.appspot.com/o/json%2F$userID%2F$packageName-$platformType?alt=media';
      final data = await http.get(Uri.parse(url));
      if (data.statusCode != 200) throw '[MNCAPPS] Error getting data';
      if (data.body.isEmpty) throw '[MNCAPPS] Error getting data body empty, Check your UserID, or Product Identifier';
      final res = ResponseData.fromJson(data.body);

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
