import 'package:blog_app/core/common/entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.name,
    required super.id,
    super.userProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      userProfile: json['user_profile'] ?? '',
    );
  }

  //CopyWith method
  UserModel copyWith({
    String? email,
    String? name,
    String? id,
    String? userProfile,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
