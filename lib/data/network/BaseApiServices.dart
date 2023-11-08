import '../../model/signup_model.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url, SignUpData data);
  Future<dynamic> getoneApiResponse(String url, int id);
}
