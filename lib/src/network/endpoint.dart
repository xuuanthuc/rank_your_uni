abstract class ApiEndpoint{
  static String get search => '/schools';
  static String get reviews => '/reviews';
  static String get authenticate => '/authenticate';
  static String get googleAuthenticate => '/oauth2Authentication';
  static String get report => '/reports';
  static String get register => '/register';
  static String get profile => '/admin/users';
  static String get password => '/account/change-password';
  static String get contact => '/contact';
  static String get myReviews => '/reviews-of-user';
  static String get forgotPassword => '/account/reset-password/init';
  static String get resetPassword => '/account/reset-password/finish';
}