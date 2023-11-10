import 'package:flutter/cupertino.dart';
import 'package:CoachZiad/data/response/api_response.dart';
// import 'package:CoachZiad/model/students_model.dart';
import 'package:CoachZiad/respository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  // ApiResponse<StudentListModel> moviesList = ApiResponse.loading();

  // setMoviesList(ApiResponse<StudentListModel> response) {
  //   moviesList = response;
  //   notifyListeners();
  // }

  // Future<void> fetchMoviesListApi() async {
  //   setMoviesList(ApiResponse.loading());

  //   _myRepo.fetchMoviesList().then((value) {
  //     setMoviesList(ApiResponse.completed(value));
  //   }).onError((error, stackTrace) {
  //     setMoviesList(ApiResponse.error(error.toString()));
  //   });
  // }
}
