import 'package:template/src/admin.dart';
import './../../global/flavor/app_flavor.dart';
import 'initial_app.dart';

void main() {
  AppFlavor.appFlavor = Flavor.development;
  initialApp(() => const MyAdmin());
}