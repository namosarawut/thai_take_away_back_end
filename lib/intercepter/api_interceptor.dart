// service/api_interceptor.dart

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/data/local_storage_helper.dart';
import 'package:thai_take_away_back_end/repositores/auth_repository.dart';

class ApiInterceptor extends Interceptor {
  final Dio _dio;
  final AuthRepository _authRepo;
  bool _isRefreshing = false;
  final List<QueueItem> _queue = [];

  ApiInterceptor(this._dio, this._authRepo);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await LocalStorageHelper.getToken();
    options.headers["Authorization"] = "Bearer $token";
    options.headers["Content-Type"] = "application/json";
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final status = err.response?.statusCode;
    final req = err.requestOptions;

    // ถ้า 401 (Unauthorized) และยังไม่กำลังรีเฟรช
    if (status == 401 && !_isRefreshing) {
      _isRefreshing = true;

      // เก็บ request เดิมเข้า queue รอ retry
      final completer = Completer<Response>();
      _queue.add(QueueItem(req, completer));

      // เรียก refresh token
      _authRepo.refreshToken().then((newToken) {
        // หลังรีเฟรชสำเร็จ ให้ retry ทั้ง queue
        for (var item in _queue) {
          item.request.headers["Authorization"] = "Bearer $newToken";
          _dio.fetch(item.request).then(item.completer.complete).catchError(item.completer.completeError);
        }
      }).catchError((e) {
        // ถ้ารีเฟรชล้ม ให้ clear session และโยน error เดิม
        LocalStorageHelper.clearAll();
        for (var item in _queue) {
          item.completer.completeError(err);
        }
      }).whenComplete(() {
        _queue.clear();
        _isRefreshing = false;
      });

      // รอให้ queue retry เสร็จ แล้วส่ง response
      completer.future.then((r) => handler.resolve(r)).catchError((e) => handler.next(err));
    } else {
      // กรณีอื่นๆ (ไม่ใช่ 401) หรือ กำลังรีเฟรชอยู่ ให้ throw error ปกติ
      handler.next(err);
    }
  }
}

class QueueItem {
  final RequestOptions request;
  final Completer<Response> completer;
  QueueItem(this.request, this.completer);
}
