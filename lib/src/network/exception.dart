class ResponseException implements Exception {
  final String? title;
  final int? code;

  ResponseException(this.code, this.title);

  @override
  String toString() {
    return title ?? '';
  }
}