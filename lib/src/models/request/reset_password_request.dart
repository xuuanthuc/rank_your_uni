class ResetPasswordRaw {
  final String newPassword;
  final String key;

  ResetPasswordRaw({
    required this.newPassword,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newPassword'] = newPassword;
    data['key'] = key;
    return data;
  }
}
