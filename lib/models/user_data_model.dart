class UserDataModel {
  final String id;
  final String email;
  final String username;
  final String createdAt;

  UserDataModel({
    required this.id,
    required this.email,
    required this.username,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'createdAt': createdAt,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
