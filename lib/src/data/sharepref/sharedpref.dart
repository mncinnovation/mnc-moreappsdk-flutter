import '../constant/constant.dart';
import '../model/responsedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPref {
  Future<ResponseData?> getDataSP() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final data = sp.getString(Constant.sharedPrefData);
      if (data == null) return null;
      return ResponseData.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setDataSP(ResponseData data) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString(Constant.sharedPrefData, data.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<DateTime?> getDataSavedTimeSP() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final data = sp.getString(Constant.sharedPrefLastSaved);
      if (data == null) return null;
      return DateTime.parse(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setDataSavedTimeSP() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString(Constant.sharedPrefLastSaved, DateTime.now().toIso8601String());
    } catch (e) {
      rethrow;
    }
  }
}
