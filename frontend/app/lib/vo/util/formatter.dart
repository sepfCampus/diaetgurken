class Formatter
{
  static String formatClientId(int clientId)
  {
    return clientId.toString().padLeft(4, '0');
  }
}
