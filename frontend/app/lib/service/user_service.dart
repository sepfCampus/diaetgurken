import 'package:app/data/daos/user_base_dao.dart';
import 'package:app/data/entities/client_file_entity.dart';
import 'package:app/data/entities/conversation_entity.dart';
import 'package:app/data/entities/settings_entity.dart';
import 'package:app/data/entities/user_entity.dart';
import 'package:app/service/util/entity_vo_converter_base_util.dart';
import 'package:app/vo/user.dart';

class UserService
{
  UserBaseDao<UserEntity> _userDao;
  EntityVoConverterBaseUtil<SettingsEntity, UserEntity, ConversationEntity, ClientFileEntity> _entityVoConverterUtil;

  UserService(this._userDao, this._entityVoConverterUtil);

  Future<User> register(User user, String password) async
  {
    UserEntity userEntity = await this._userDao.register(this._entityVoConverterUtil.convertUserVoToEntity(user), password);
    return this._entityVoConverterUtil.convertUserEntityToVo(userEntity);
  }

  Future<User> login(String email, String registerNr, String password) async
  {
    UserEntity userEntity = await this._userDao.login(email, registerNr, password);
    return this._entityVoConverterUtil.convertUserEntityToVo(userEntity);
  }

  Future<void> logout() async
  {
    await this._userDao.logout();
  }

  Future<User> getCurrentUser() async
  {
    UserEntity userEntity = await this._userDao.getCurrentUser();
    return this._entityVoConverterUtil.convertUserEntityToVo(userEntity);
  }

  Future<User> updateUser(User updatedUser, String? password) async
  {
    UserEntity userEntity = await this._userDao.updateUser(this._entityVoConverterUtil.convertUserVoToEntity(updatedUser), password);
    return this._entityVoConverterUtil.convertUserEntityToVo(userEntity);
  }

  Future<void> deleteUser(User user) async
  {
    await this._userDao.deleteUser(this._entityVoConverterUtil.convertUserVoToEntity(user));
  }

  Future<bool> isLoggedIn() async
  {
    return await this._userDao.isLoggedIn();
  }
}
