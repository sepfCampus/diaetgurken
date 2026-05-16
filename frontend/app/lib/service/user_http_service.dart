import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/daos/http/api/session_store.dart';

class UserHttpService
{
  final ApiClient apiClient;
  final SessionStore sessionStore;

  UserHttpService({ required this.apiClient, required this.sessionStore });

  Future<void> register({ required String email, required String passwort, required String registerNr }) async
  {
    final response = await apiClient.post('/auth/register', body:
    {
      'email': email,
      'passwort': passwort,
      'registerNr': registerNr,
    });

    if (!response.isSuccess)
    {
      throw Exception(response.body);
    }
  }

  Future<void> login({ required String email, required String passwort, required String registerNr }) async
  {
    final response = await apiClient.post('/auth/login', body:
    {
      'email': email,
      'passwort': passwort,
      'registerNr': registerNr,
    });

    if (!response.isSuccess)
    {
      throw Exception(response.body);
    }
  }

  Future<void> logout() async
  {
    final response = await apiClient.post('/auth/logout');

    if (!response.isSuccess)
    {
      throw Exception('Logout fehlgeschlagen.');
    }

    await sessionStore.clear();
  }

  Future<bool> isLoggedIn() async
{
  try
  {
    final response = await apiClient.get('/auth/whoami');
    return response.isSuccess;
  }
  catch (e)
  {
    return false;
  }
}
}