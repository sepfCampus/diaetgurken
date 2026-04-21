import 'dart:convert';

import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/daos/http/api/api_response.dart';
import 'package:app/data/daos/http/api/session_store.dart';
import 'package:flutter/foundation.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class SessionApiClient implements ApiClient
{
  final String baseUrl;
  final SessionStore sessionStore;
  late final http.Client _client;

  SessionApiClient({ required this.baseUrl, required this.sessionStore })
  {
    if(kIsWeb)
    {
      final BrowserClient browserClient = BrowserClient()..withCredentials = true;
      _client = browserClient;
    }
    else
    {
      _client = http.Client();
    }
  }

  Uri _buildUri(String path) => Uri.parse('$baseUrl$path');

  Future<Map<String, String>> _headers() async
  {
    final Map<String, String> headers =
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if(!kIsWeb)
    {
      final String? cookieHeader = await sessionStore.readCookieHeader();

      if(cookieHeader != null && cookieHeader.isNotEmpty)
      {
        headers['Cookie'] = cookieHeader;
      }
    }

    return headers;
  }

  Future<void> _storeCookies(http.Response response) async
  {
    if(kIsWeb)
    {
      return;
    }

    final String? rawSetCookie = response.headers['set-cookie'];

    if(rawSetCookie == null || rawSetCookie.isEmpty)
    {
      return;
    }

    final String cookiePair = rawSetCookie.split(';').first.trim();

    if(cookiePair.isNotEmpty)
    {
      await sessionStore.writeCookieHeader(cookiePair);
    }
  }

  @override
  Future<ApiResponse> get(String path) async
  {
    final response = await _client.get(
      _buildUri(path),
      headers: await _headers(),
    );

    await _storeCookies(response);

    return ApiResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }

  @override
  Future<ApiResponse> post(String path, { Map<String, dynamic>? body }) async
  {
    final response = await _client.post(
      _buildUri(path),
      headers: await _headers(),
      body: body == null ? null : jsonEncode(body),
    );

    await _storeCookies(response);

    return ApiResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }

  @override
  Future<ApiResponse> put(String path, { Map<String, dynamic>? body }) async
  {
    final response = await _client.put(
      _buildUri(path),
      headers: await _headers(),
      body: body == null ? null : jsonEncode(body),
    );

    await _storeCookies(response);

    return ApiResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }

  @override
  Future<ApiResponse> delete(String path, { Map<String, dynamic>? body }) async
  {
    final response = await _client.delete(
      _buildUri(path),
      headers: await _headers(),
      body: body == null ? null : jsonEncode(body),
    );

    await _storeCookies(response);

    return ApiResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }

  void close()
  {
    _client.close();
  }
}
