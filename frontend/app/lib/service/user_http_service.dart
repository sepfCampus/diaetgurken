import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/daos/http/api/session_store.dart';

class UserHttpService
{
  final ApiClient apiClient;
  final SessionStore sessionStore;

  UserHttpService({ required this.apiClient, required this.sessionStore });

  Future<void> login({ required String email, required String password }) async
  {
    final response = await apiClient.post('/auth/login', body:
    {
        'email': email,
        'password': password,
    });

    if(!response.isSuccess)
    {
      throw Exception('Login fehlgeschlagen.');
    }
  }

  Future<void> logout() async
  {
    final response = await apiClient.post('/auth/logout');

    if(!response.isSuccess)
    {
      throw Exception('Logout fehlgeschlagen.');
    }

    await sessionStore.clear();
  }

  Future<bool> isLoggedIn() async
  {
    final response = await apiClient.get('/auth/me');
    return response.isSuccess;
  }
}
