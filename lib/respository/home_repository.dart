// import 'package:zezo/data/network/BaseApiServices.dart';
// import 'package:zezo/data/network/NetworkApiService.dart';
// import 'package:zezo/model/movies_model.dart';
// import 'package:zezo/model/students_model.dart';
// import 'package:zezo/res/app_url.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../res/app_url.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  // Future<StudentListModel> fetchMoviesList() async {
  //   try {
  //     dynamic response =
  //         await _apiServices.getGetApiResponse(AppUrl.studentsListEndPoint);
  //     print(response);
  //     return response = StudentListModel.fromJson(response);
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
