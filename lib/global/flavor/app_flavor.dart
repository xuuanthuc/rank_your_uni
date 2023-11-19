
enum Flavor {
  development,
  release,
}

class AppFlavor {
  static Flavor appFlavor = Flavor.development;

  static String get baseApi {
    switch (appFlavor) {
      case Flavor.release:
        return 'http://13.211.174.175:8081/api';
      case Flavor.development:
        return 'http://13.211.174.175:8081/api';
      default:
        return 'http://13.211.174.175:8081/api';
    }
  }
}