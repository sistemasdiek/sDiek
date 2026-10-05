class RoleModel {
  final String id;
  final String name;
  final String label;
  final List<String> views;
  final DateTime? createdAt;

  RoleModel({
    required this.id,
    required this.name,
    required this.label,
    required this.views,
    this.createdAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      label: json['label'] ?? '',
      views: json['views'] != null ? List<String>.from(json['views']) : [],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'label': label,
      'views': views,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  bool hasPermission(String viewName) {
    if (name == 'admin') return true;
    return views.contains(viewName);
  }
}
