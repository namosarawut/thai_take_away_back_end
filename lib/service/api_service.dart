import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/intercepter/api_interceptor.dart';
import 'package:thai_take_away_back_end/repositores/auth_repository.dart';



class ApiService {
  late Dio _dio;
  late AuthRepository _authRepo;
  ApiService() {
    _dio = Dio(BaseOptions(baseUrl: "http://192.168.159.145:3000"));
    _authRepo = AuthRepository(this);
    _dio.interceptors.add(ApiInterceptor(_dio, _authRepo));
  }
  // Function สำหรับ GET
  Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    return await _dio.get(endpoint, queryParameters: query);
  }

  // Function สำหรับ POST
  Future<Response> post(String endpoint, {dynamic data}) async {
    return await _dio.post(endpoint, data: data);
  }

  // Function สำหรับ PUT
  Future<Response> put(String endpoint, {dynamic data}) async {
    return await _dio.put(endpoint, data: data);
  }

  // Function สำหรับ DELETE
  Future<Response> delete(String endpoint, {dynamic data}) async {
    return await _dio.delete(endpoint, data: data);
  }
}
