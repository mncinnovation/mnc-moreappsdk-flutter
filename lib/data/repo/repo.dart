import 'package:mncapps/data/interface/libinterface.dart';
import 'package:mncapps/data/model/cachingstrategy.dart';
import 'package:mncapps/data/model/responsedata.dart';
import 'package:mncapps/data/service/service.dart';
import 'package:mncapps/data/sharepref/sharedpref.dart';

abstract class Repo with SharedPref, Service {
  Future<ResponseData> getDataRepo() async {
    try {
      if (LibInterface.cachingStrategy == CachingStrategy.None) {
        //Network
        final data = await getDataNetwork(LibInterface.currentUserID, LibInterface.packageName);
        await setDataSavedTimeSP();
        await setDataSP(data);
        return data;
      }

      final lastSaved = await getDataSavedTimeSP();
      if (lastSaved == null) {
        //Network
        final data = await getDataNetwork(LibInterface.currentUserID, LibInterface.packageName);
        await setDataSavedTimeSP();
        await setDataSP(data);
        return data;
      }

      final lastDay = DateTime.now().add(LibInterface.cachingStrategy.getDuration());
      if ((lastDay.day - lastSaved.day) > LibInterface.cachingStrategy.getValue()) {
        //Network
        final data = await getDataNetwork(LibInterface.currentUserID, LibInterface.packageName);
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
