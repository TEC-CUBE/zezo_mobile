class BlogPost {
  final int id;
  final String image;
  final String name;
  final bool status;
  final String created_at;
  final String updated_at;
  final String contact;
  // Add other fields as needed

  BlogPost({
    required this.id,
    required this.image,
    required this.name,
    required this.status,
    required this.created_at,
    required this.updated_at,
    required this.contact,
    // Add other fields as needed
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] ?? 0, // Provide a default value for 'id'
      image: json['image'] ?? "", // Provide a default value for 'image'
      name: json['name'] ?? "", // Provide a default value for 'name'
      status: json['status']?.toString().toLowerCase() == 'true' ?? false,
      created_at:
          json['created_at'] ?? "", // Provide a default value for 'created_at'
      updated_at:
          json['updated_at'] ?? "", // Provide a default value for 'updated_at'
      contact: json['contact'] ?? "", // Provide a default value for 'contact'
      // Parse other fields as needed
    );
  }
}
