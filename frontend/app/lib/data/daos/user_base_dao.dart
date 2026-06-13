import 'package:app/data/entities/user_entity.dart';

abstract class UserBaseDao<T extends UserEntity>
{
  Future<T> register(T userEntity, String password);
  Future<T> login(String email, String registerNr, String password);
  Future<void> logout();

  Future<T> getCurrentUser();

  Future<T> updateUser(T updatedUserEntity);
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> deleteUser(T userEntity);

  Future<bool> isLoggedIn();
}
