import 'package:app/data/entities/client_file_entity.dart';

abstract class ClientFileBaseDao<T extends ClientFileEntity>
{
  Future<List<T>> getAll();
  Future<void> create(String clearName);
  Future<void> delete(int id);
  Future<String> getClearName(String clientFileId, String password);
}
