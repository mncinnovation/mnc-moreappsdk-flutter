import '../model/cachingstrategy.dart';

class LibInterface {
  String? currentUserID;
  String? packageName;
  CachingStrategy? cachingStrategy;
  LibInterface({
    this.currentUserID,
    this.packageName,
    this.cachingStrategy,
  });
}
