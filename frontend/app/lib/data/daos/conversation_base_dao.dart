import 'package:app/data/entities/conversation_entity.dart';

abstract class ConversationBaseDao<T extends ConversationEntity>
{
  Future<List<T>> getAll(int clientFileId);
  Future<T> getById(int clientFileId, int conversationId);
  Future<T> create(int clientFileId, String date);
  Future<T> update(T conversation);
  Future<void> delete(int clientFileId, int conversationId);
}
