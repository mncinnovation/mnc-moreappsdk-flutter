import 'package:mncapps/data/model/responsedata.dart';
import 'package:mncapps/data/repo/repo.dart';

class MNCAppsDataInterface extends Repo {
  Future<ResponseData> getData() => getDataRepo();
}
