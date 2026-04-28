import 'package:app/vo/user.dart';

abstract class UserBaseService
{
  Future<User> register(User user, String password);
  Future<User> login(String email, String password);
  Future<void> logout();

  Future<User> getCurrentUser();

  Future<User> updateUser(User updatedUser, String? password);
  Future<void> deleteUser(User user);
}
