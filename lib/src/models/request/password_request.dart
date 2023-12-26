class PasswordRaw {
  final String currentPassword;
  final String newPassword;

  PasswordRaw({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPassword'] = currentPassword;
    data['newPassword'] = newPassword;
    return data;
  }
}

