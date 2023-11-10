import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
// import 'package:CoachZiad/data/app_excaptions.dart';
// import 'package:CoachZiad/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CoachZiad/data/app_excaptions.dart';
import 'package:CoachZiad/data/network/BaseApiServices.dart';

import '../../model/signup_model.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
      print(responseJson);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future getoneApiResponse(String url, int id) async {
    dynamic responseJson;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    try {
      final response = await http.get(Uri.parse('$url/$id'), headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
      print(responseJson);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  @override
  Future getPostApiResponse(String url, SignUpData data) async {
    dynamic responseJson;
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final jsonBody = jsonEncode(data.toJson());
    try {
      Response response =
          await post(Uri.parse(url), headers: headers, body: data).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
