import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/intercepter/api_interceptor.dart';
import 'package:thai_take_away_back_end/repositores/auth_repository.dart';



class ApiService {
  late Dio _dio;
  late AuthRepository _authRepo;
  ApiService() {
    _dio = Dio(BaseOptions(baseUrl: "http://172.20.10.3:3000"));
    _authRepo = AuthRepository(this);
    _dio.interceptors.add(ApiInterceptor(_dio, _authRepo));
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    return await _dio.get(endpoint, queryParameters: query);
  }


  Future<Response> post(String endpoint, {dynamic data}) async {
    return await _dio.post(endpoint, data: data);
  }


  Future<Response> put(String endpoint, {dynamic data}) async {
    return await _dio.put(endpoint, data: data);
  }


  Future<Response> delete(String endpoint, {dynamic data}) async {
    return await _dio.delete(endpoint, data: data);
  }
}
