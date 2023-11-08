import 'dart:convert';

class SignUpData {
  String aim;
  String birthday;
  String focuson;
  String heigh;
  bool ismale;
  // String selectedGoal;
  String name;
  String weigh;
  String bodytype;
  String objective;
  String phoneNumber;
  String username;
  String password;
  String goal;

  SignUpData({
    required this.aim,
    required this.birthday,
    required this.focuson,
    required this.heigh,
    required this.ismale,
    // required this.selectedGoal,
    required this.name,
    required this.weigh,
    required this.bodytype,
    required this.objective,
    required this.phoneNumber,
    required this.username,
    required this.password,
    required this.goal,
  });

  Map<String, dynamic> toJson() {
    return {
      "aim": aim,
      "birthday": birthday,
      "focuson": focuson,
      "heigh": heigh,
      "ismale": ismale,
      // "selectedGoal": selectedGoal,
      "name": name,
      "weigh": weigh,
      "bodytype": bodytype,
      "objective": objective,
      "phone_number": phoneNumber,
      "username": username,
      "password": password,
      "goal": goal,
    };
  }
}
