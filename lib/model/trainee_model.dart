// trainee_model.dart
class TraineePost {
  final int id;
  final String image;
  final String name;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;

  TraineePost({
    required this.id,
    required this.image,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TraineePost.fromJson(Map<String, dynamic> json) {
    return TraineePost(
      id: json['id'] ?? 0,
      image: json['image'] ?? "",
      name: json['name'] ?? "",
      status: json['status']?.toString().toLowerCase() == 'true' ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
