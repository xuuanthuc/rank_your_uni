class RYUResponse {
  final String? errorMessage;
  final bool isSuccess;
  final int? code;
  final dynamic data;

  const RYUResponse({
    required this.isSuccess,
    this.errorMessage,
    this.code,
    this.data,
  });
}
