import 'dart:typed_data';

class ApiResponse
{
  final int statusCode;
  final String body;
  final Uint8List? bodyBytes;

  const ApiResponse({ required this.statusCode, required this.body, this.bodyBytes });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}