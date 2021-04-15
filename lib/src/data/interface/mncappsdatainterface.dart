import 'package:mncapps/src/data/interface/libinterface.dart';

import '../model/responsedata.dart';
import '../repo/repo.dart';

class MNCAppsDataInterface extends Repo {
  Future<ResponseData?> getData(LibInterface libInterface) =>
      getDataRepo(libInterface);
}
