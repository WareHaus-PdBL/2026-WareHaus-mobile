import 'package:core_services/interceptors/api_exception.dart';
import 'package:dio/dio.dart';

class AppErrorHandler {
  /// Ekstrak pesan error yang bersih dari exception apapun.
  /// Prioritas: ApiException.message → DioException.message → e.toString()
  static String extractMessage(Object e) {
    if (e is DioException) {
      // ErrorInterceptor menyimpan ApiException di field `error`
      if (e.error is ApiException) {
        return (e.error as ApiException).message;
      }
      // Fallback ke response data jika ada
      final data = e.response?.data;
      if (data is Map) {
        final msg = data['detail'] ?? data['message'];
        if (msg is String && msg.isNotEmpty) return msg;
      }
      // Fallback ke tipe koneksi
      if (e.type == DioExceptionType.connectionError) {
        return 'Tidak dapat terhubung ke server.';
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        return 'Server tidak merespons. Coba lagi nanti.';
      }
    }
    if (e is ApiException) return e.message;
    return e.toString();
  }
}
