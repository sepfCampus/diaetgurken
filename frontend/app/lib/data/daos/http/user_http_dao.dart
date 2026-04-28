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

  Future<UserHttpEntity> register(UserHttpEntity userEntity, String password) async
  {
    final response = await apiClient.post('/auth/register',
                                          body:
                                          {
                                            'email': userEntity.email,
                                            'registerNr': userEntity.registerNr,
                                            'password': password
                                          },
    );

    if(!response.isSuccess)
    {
      throw Exception('User konnte nicht registriert werden.');
    }

    else
    {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserHttpEntity(json['id'] as int, json['email'] as String, json['registerNr'] as String);
    }
  }

  Future<UserHttpEntity> login(String email, String password) async
  {
    final response = await apiClient.post('/auth/login',
                                          body:
                                          {
                                            'email': email,
                                            'password': password
                                          });

    if(!response.isSuccess)
    {
      throw Exception('Login fehlgeschlagen.');
    }

    else
    {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserHttpEntity(json['id'] as int, json['email'] as String, json['registerNr'] as String);
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

  Future<UserHttpEntity> getCurrentUser() async
  {
    final response = await apiClient.post('/auth/whoami', body: {});

    if(!response.isSuccess)
    {
      throw Exception('User konnte nicht abgefragt werden.');
    }

    else
    {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserHttpEntity(json['id'] as int, json['email'] as String, json['registerNr'] as String);
    }
  }

  Future<UserHttpEntity> updateUser(UserHttpEntity updatedUserEntity, String? password) async
  {
    final response = await apiClient.put('/users',
                                         body:
                                         {
                                          'email': updatedUserEntity.email,
                                          'registerNr': updatedUserEntity.registerNr,
                                          'password': password
                                         });

    if(!response.isSuccess)
    {
      throw Exception('User konnte nicht geändert werden.');
    }

    else
    {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserHttpEntity(json['id'] as int, json['email'] as String, json['registerNr'] as String);
    }
  }

  Future<void> deleteUser(UserHttpEntity userEntity) async
  {
    final response = await apiClient.delete('/users');

    if(!response.isSuccess)
    {
      throw Exception('User konnte nicht gelöscht werden.');
    }
  }
}
