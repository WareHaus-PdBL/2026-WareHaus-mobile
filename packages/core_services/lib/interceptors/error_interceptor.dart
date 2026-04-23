import 'package:core_services/api/api_exception.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    String errorMessage = 'Terjadi kesalahan sistem. Silakan coba lagi nanti.';
    String? errorTitle;

    if (err.response?.data != null && err.response?.data is Map) {
      final data = err.response!.data;
      errorMessage = data['detail'] ?? data['message'] ?? errorMessage;
      errorTitle = data['title'];
    } else {
      if (err.type == DioExceptionType.connectionError) {
        errorMessage =
            'Tidak dapat terhubung ke server. Silakan periksa koneksi internet Anda.';
      } else if (err.type == DioExceptionType.connectionTimeout) {
        errorMessage =
            'Server tidak merespons.(Timeout) Silakan coba lagi nanti.';
      }
    }
    final apiException = ApiException(
      message: errorMessage,
      title: errorTitle,
      statusCode: err.response?.statusCode,
    );
    handler.next(err.copyWith(error: apiException));
  }
}
