abstract class ClientFileEntity
{
  final int _id;
  final int _userId;

  ClientFileEntity(this._id, this._userId);
  
  int get id => this._id;
  int get userId => this._userId;
}
