import 'package:dio/dio.dart';
import 'package:notex_mobile/models/NoteModel.dart';
import 'package:notex_mobile/utils/environment.dart';

class ApiService {
  final _dio = Dio();

  /// fetch all notes
  Future<List<NoteModel>> fetchAllNotes() async {
    List<NoteModel> notesList = [];
    try {
      // isLoading.value = true;
      var response = await _dio.get(
        "${Environment.API_BASE_URL}/notes?userid=N9Wgm26kMk5yKTNfWyA0",
      );
      List<dynamic> responseData = response.data;
      notesList = responseData.map((item) => NoteModel.fromJson(item)).toList();
    } on DioException catch (e) {
      print(e.response?.data);
    }
    return notesList;
  }

  /// login
  Future<Response> login(String email, String password) async {
    return await _dio.post(
      "${Environment.API_BASE_URL}/user/login",
      data: {"email": email, "password": password},
    );
  }

  /// auth (check token)
  Future<Response> authentication(String token) async {
    return await _dio.post(
      "${Environment.API_BASE_URL}/user/auth",
      data: {"token": token},
    );
  }
}
