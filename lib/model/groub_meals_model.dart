class GroupMeals {
  final String day;

  GroupMeals({
    required this.day,
  });

  factory GroupMeals.fromJson(Map<String, dynamic> json) {
    return GroupMeals(
      day: json['day'] as String,
    );
  }
}
