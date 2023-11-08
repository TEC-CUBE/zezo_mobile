class Meal {
  final int id;
  final String name;
  final String weight;
  final String fat;
  final String calories;
  final String carb;
  final String protein;
  final String image;

  Meal({
    required this.id,
    required this.name,
    required this.weight,
    required this.fat,
    required this.calories,
    required this.carb,
    required this.protein,
    required this.image,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] ?? 0, // Provide a default value for null
      name: json['name'] ?? "", // Provide a default value for null
      weight: json['weight'] ?? "", // Provide a default value for null
      fat: json['fat'] ?? "", // Provide a default value for null
      calories: json['calories'] ?? "", // Provide a default value for null
      carb: json['carb'] ?? "", // Provide a default value for null
      protein: json['protein'] ?? "", // Provide a default value for null
      image: json['image'] ?? "", // Provide a default value for null
    );
  }
}
