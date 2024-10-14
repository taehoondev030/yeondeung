class User {
  String email;
  String password;
  String name;

  User({
    required this.email,   // 필수 필드로 지정
    required this.password,
    required this.name,
  });

  // JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }
}
