abstract class UserEntity
{
  final int _id;
  final String _email;
  final String _registerNr;

  UserEntity(this._id, this._email, this._registerNr);

  int get id => this._id;
  String get email => this._email;
  String get registerNr => this._registerNr;
}
