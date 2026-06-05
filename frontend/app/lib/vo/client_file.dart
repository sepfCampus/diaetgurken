import 'package:app/vo/conversation.dart';
import 'package:app/vo/user.dart';

class ClientFile
{
  final int _id;
  final User _user;
  final List<Conversation> _conversations;

  ClientFile(this._id, this._user, this._conversations);

  int get id => this._id;
  User get user => this._user;
  List<Conversation> get conversations => this._conversations;
}
