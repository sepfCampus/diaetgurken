import 'dart:convert';
import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/daos/http/api/session_store.dart';
import 'package:app/data/daos/user_base_dao.dart';
import 'package:app/data/entities/http/user_http_entity.dart';

class UserHttpDao extends UserBaseDao<UserHttpEntity>
{
  final ApiClient apiClient;
  final SessionStore sessionStore;

  UserHttpDao({ required this.apiClient, required this.sessionStore });

  @override
  Future<UserHttpEntity> register(UserHttpEntity userEntity, String password) async
  {
    final response = await apiClient.post('/auth/register',
                                          body:
                                          {
                                            'email': userEntity.email,
                                            'registerNr': userEntity.registerNr,
                                            'passwort': password
                                          },
    );

    if(!response.isSuccess)
    {
      throw Exception('User konnte nicht registriert werden.');
    }

    else
    {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserHttpEntity.fromJson(json);
    }
  }

  @override
  Future<UserHttpEntity> login(String email, String registerNr, String password) async
  {
    final response = await apiClient.post('/auth/login',
                                          body:
                                          {
                                            'email': email,
                                            'registerNr': registerNr,
                                            'passwort': password
                                          });

    if(!response.isSuccess)
    {
      throw Exception('Login fehlgeschlagen.');
    }

    else
    {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserHttpEntity.fromJson(json);
    }
  }

  @override
  Future<void> logout() async
  {
    final response = await apiClient.post('/auth/logout');

    if(!response.isSuccess)
    {
      throw Exception('Logout fehlgeschlagen.');
    }

    await sessionStore.clear();
  }

  @override
  Future<UserHttpEntity> getCurrentUser() async
  {
    final response = await apiClient.get('/auth/whoami');

    if(!response.isSuccess)
    {
      throw Exception('User konnte nicht abgefragt werden.');
    }

    else
    {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserHttpEntity.fromJson(json);
    }
  }

  @override
  Future<UserHttpEntity> updateUser(UserHttpEntity updatedUserEntity, String? password) async
  {
    final response = await apiClient.put('/users',
                                         body:
                                         {
                                          'email': updatedUserEntity.email,
                                          'registerNr': updatedUserEntity.registerNr,
                                          'passwort': password
                                         });

    if(!response.isSuccess)
    {
      throw Exception('User konnte nicht geändert werden.');
    }

    else
    {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserHttpEntity.fromJson(json);
    }
  }

  @override
  Future<void> deleteUser(UserHttpEntity userEntity) async
  {
    final response = await apiClient.delete('/users');

    if(!response.isSuccess)
    {
      throw Exception('User konnte nicht gelöscht werden.');
    }
  }

  @override
  Future<bool> isLoggedIn() async
  {
    try
    {
      final response = await apiClient.get('/auth/whoami');
      return response.isSuccess;
    }

    catch(exception)
    {
      return false;
    }
  }
}
