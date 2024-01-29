class SignInWithGoogleRaw {
  final String displayName;
  final String email;
  final String id;
  final String accessToken;

  SignInWithGoogleRaw({
    required this.displayName,
    required this.email,
    required this.id,
    required this.accessToken,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['id'] = id;
    data['accessToken'] = accessToken;
    return data;
  }
}
