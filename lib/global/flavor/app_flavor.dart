
enum Flavor {
  development,
  release,
}

class AppFlavor {
  static Flavor appFlavor = Flavor.development;

  static String get baseApi {
    switch (appFlavor) {
      case Flavor.release:
        return 'https://api.rankyouruni.com/api';
      case Flavor.development:
        return 'https://api.rankyouruni.com/api';
      default:
        return 'http://api.rankyouruni.com/api';
    }
  }
}