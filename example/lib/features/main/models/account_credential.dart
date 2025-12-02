class AccountCredential {
  int id;
  String? password;
  String? serverUrl;
  AccountCredential({required this.id, this.password, this.serverUrl});

  Map<String, dynamic> toJson() {
    return {'id': id, 'password': password, 'serverUrl': serverUrl};
  }

  factory AccountCredential.fromJson(Map<String, dynamic> json) {
    return AccountCredential(
      id: json['id'],
      password: json['password'],
      serverUrl: json['serverUrl'],
    );
  }
}
