class UserData {
  final String id;
  final String email;
  final String username;
  final String password;

  UserData({required this.id, required this.email, required this.username, required this.password,});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'email': email});
    result.addAll({'username': username});
    result.addAll({'password': password});
  
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
