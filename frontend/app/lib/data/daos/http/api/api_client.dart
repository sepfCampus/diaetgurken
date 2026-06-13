import 'package:app/data/daos/http/api/api_response.dart';

abstract class ApiClient
{
  Future<ApiResponse> get(String path);
  Future<ApiResponse> post(String path, { Map<String, dynamic>? body });
  Future<ApiResponse> getBytes(String path);
  Future<ApiResponse> put(String path, { Map<String, dynamic>? body });
  Future<ApiResponse> delete(String path, { Map<String, dynamic>? body });
}
