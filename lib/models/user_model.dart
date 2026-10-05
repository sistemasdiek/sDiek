import 'role_model.dart';

class UserModel {
  final String id;
  final String email;
  final String? fullName;
  final String? roleName;
  final RoleModel? role;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.email,
    this.fullName,
    this.roleName,
    this.role,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, {RoleModel? role}) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['user_metadata']?['full_name'] ?? json['full_name'],
      roleName: json['role'] ?? json['user_metadata']?['role'],
      role: role,
      avatarUrl: json['user_metadata']?['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': roleName,
      'avatar_url': avatarUrl,
    };
  }

  bool canAccessView(String viewName) {
    if (role == null) return true; // Default view access
    return role!.hasPermission(viewName);
  }
}
