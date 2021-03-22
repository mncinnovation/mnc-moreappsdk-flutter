import '../interface/libinterface.dart';
import '../model/cachingstrategy.dart';
import '../model/responsedata.dart';
import '../service/service.dart';
import '../sharepref/sharedpref.dart';

abstract class Repo with SharedPref, Service {
  Future<ResponseData?> getDataRepo(LibInterface? libInterface) async {
    try {
      if (libInterface == null) {
        throw "Please input user id";
      }
      print("[MNC Apps] Calling data");
      if (libInterface.cachingStrategy == CachingStrategy.None) {
        //Network
        final data = await getDataNetwork(libInterface.currentUserID, libInterface.packageName);
        await setDataSavedTimeSP();
        await setDataSP(data);
        return data;
      }

      final lastSaved = await getDataSavedTimeSP();
      if (lastSaved == null) {
        //Network
        final data = await getDataNetwork(libInterface.currentUserID, libInterface.packageName);
        await setDataSavedTimeSP();
        await setDataSP(data);
        return data;
      }

      final lastDay = DateTime.now().add(libInterface.cachingStrategy.getDuration());
      if ((lastDay.day - lastSaved.day) > libInterface.cachingStrategy.getValue()) {
        //Network
        final data = await getDataNetwork(libInterface.currentUserID, libInterface.packageName);
        await setDataSavedTimeSP();
        await setDataSP(data);
        return data;
      }

      return await getDataSP();
    } catch (e) {
      rethrow;
    }
  }
}
