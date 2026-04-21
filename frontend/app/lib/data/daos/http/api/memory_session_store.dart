import 'package:app/data/daos/http/api/session_store.dart';

class MemorySessionStore implements SessionStore
{
  String? _cookieHeader;

  @override
  Future<String?> readCookieHeader() async => _cookieHeader;

  @override
  Future<void> writeCookieHeader(String cookieHeader) async
  {
    _cookieHeader = cookieHeader;
  }

  @override
  Future<void> clear() async
  {
    _cookieHeader = null;
  }
}
