import 'package:template/global/utilities/replacement_map.dart';

String removeDiacritics(String text) =>
    String.fromCharCodes(replaceCodeUnits(text.codeUnits));

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}