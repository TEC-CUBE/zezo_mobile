class LoginData {
  String? message;
  String? role;
  int? status;
  Tokens? tokens;

  LoginData({this.message, this.role, this.status, this.tokens, required String });

  LoginData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    role = json['role'];
    status = json['status'];
    tokens =
        json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['role'] = this.role;
    data['status'] = this.status;
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }
}

class Tokens {
  String? accessToken;
  String? refreshToken;
  String? username;

  Tokens({this.accessToken, this.refreshToken, this.username});

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['username'] = this.username;
    return data;
  }
}
