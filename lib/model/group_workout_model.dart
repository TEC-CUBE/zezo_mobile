import 'package:intl/intl.dart';

class GroupWorkout {
  final int id;
  final int followupId;
  final String day;
  final String action;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroupWorkout({
    required this.id,
    required this.followupId,
    required this.day,
    required this.action,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupWorkout.fromJson(Map<String, dynamic> json) {
    return GroupWorkout(
      id: json['id'],
      followupId: json['followup_id'],
      day: json['day'],
      action: json['action'],
      createdAt:
          DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(json['created_at']),
      updatedAt:
          DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(json['updated_at']),
    );
  }
}
