abstract class SessionStore
{
  Future<String?> readCookieHeader();
  Future<void> writeCookieHeader(String cookieHeader);
  Future<void> clear();
}
