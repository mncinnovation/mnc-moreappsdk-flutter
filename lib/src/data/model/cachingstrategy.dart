/// Add cache to this mncapps
enum CachingStrategy { None, Weekly, Monthly }

extension CachgingStrategyUtils on CachingStrategy? {
  Duration getDuration() {
    switch (this) {
      case CachingStrategy.Weekly:
        return Duration(days: 7);
      case CachingStrategy.Monthly:
        return Duration(days: 30);
      default:
        return Duration.zero;
    }
  }

  int getValue() {
    switch (this) {
      case CachingStrategy.Weekly:
        return 7;
      case CachingStrategy.Monthly:
        return 30;
      default:
        return 0;
    }
  }
}
