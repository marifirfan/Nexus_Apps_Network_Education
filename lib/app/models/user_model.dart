class UserModel {
  String id;
  String email;
  String profileImageUrl;

  UserModel({required this.id, required this.email, required this.profileImageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
    );
  }
}
