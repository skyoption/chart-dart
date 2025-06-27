class AccountCredential {
  int id;
  String password;

  AccountCredential({
    required this.id,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
    };
  }

  factory AccountCredential.fromJson(Map<String, dynamic> json) {
    return AccountCredential(
      id: json['id'],
      password: json['password'],
    );
  }
}
