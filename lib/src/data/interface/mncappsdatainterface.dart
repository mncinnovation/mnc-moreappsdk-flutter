import '../model/responsedata.dart';
import '../repo/repo.dart';

class MNCAppsDataInterface extends Repo {
  Future<ResponseData?> getData() => getDataRepo();
}
