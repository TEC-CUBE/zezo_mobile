class MealDetail {
  final int id;
  final int followupId;
  final int mealId;
  final String day;
  final String number;
  final String weight;
  final String actionAuthor;
  final String status;
  final String createdAt;
  final String updatedAt;
  final List<MealItem> meals;

  MealDetail({
    required this.id,
    required this.followupId,
    required this.mealId,
    required this.day,
    required this.number,
    required this.weight,
    required this.actionAuthor,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.meals,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<MealItem> mealItems = [];
    if (json['meals'] != null) {
      var mealList = json['meals'] as List;
      mealItems = mealList.map((meal) => MealItem.fromJson(meal)).toList();
    }

    return MealDetail(
      id: json['id'] as int,
      followupId: json['followup_id'] as int,
      mealId: json['meal_id'] as int,
      day: json['day'] as String,
      number: json['number'] as String,
      weight: json['weight'] as String,
      actionAuthor: json['action_author'] as String,
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      meals: mealItems,
    );
  }
}

class MealItem {
  final int id;
  final String name;
  final String image;
  final String weight;
  final String fat;
  final String calories;
  final String carb;
  final String protein;

  MealItem({
    required this.id,
    required this.name,
    required this.image,
    required this.weight,
    required this.fat,
    required this.calories,
    required this.carb,
    required this.protein,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      weight: json['weight'] ?? "",
      fat: json['fat'] ?? "",
      calories: json['calories'] ?? "",
      carb: json['carb'] ?? "",
      protein: json['protein'] ?? "",
    );
  }
}
