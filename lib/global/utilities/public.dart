abstract class Public {
  // static List<PlatformUiSettings> uiSettings = [
  //   AndroidUiSettings(
  //     toolbarTitle: 'Edit image',
  //     toolbarColor: Colors.blueGrey,
  //     toolbarWidgetColor: Colors.white,
  //     initAspectRatio: CropAspectRatioPreset.original,
  //   ),
  //   IOSUiSettings(
  //     title: 'Edit image',
  //   ),
  // ];
  static const mobileSize = 640.0;
  static const tabletSize = 768.0;
  static const laptopSize = 1024.0;
  static const desktopSize = 1200.0;
}

abstract class PageIndex {
  static const int signIn = 0;
  static const int signUpEmail = 1;
  static const int signUpPassword = 2;
  static const int updateProfile = 3;
  static const int forgotPassword = 4;
}
