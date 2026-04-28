class User
{
  int _id;
  String _registerNr;
  String _email;

  User(this._id, this._registerNr, this._email);

  int get id => this._id;
  String get registerNr => this._registerNr;
  String get email => this._email;

  void set id(int value)
  {
    this._id = value;
  }

  void set registerNr(String value)
  {
    this._registerNr = value;
  }

  void set email(String value)
  {
    this._email = value;
  }
}
