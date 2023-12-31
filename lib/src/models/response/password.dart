class ResetPassword {
  final String? status;
  final String? message;

  const ResetPassword({
    this.status,
    this.message,
  });

  factory ResetPassword.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final message = json['message'];

    return ResetPassword(
      status: status,
      message: message,
    );
  }
}