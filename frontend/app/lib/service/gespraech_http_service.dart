import 'dart:convert';

import 'package:app/data/daos/http/api/api_client.dart';

class GespraechHttpService {
  final ApiClient apiClient;

  GespraechHttpService({required this.apiClient});

  Future<List<Map<String, dynamic>>> getAll({required int klientenAkteId}) async {
    final response = await apiClient.get(
      '/users/klientenakten/$klientenAkteId/gespraeche',
    );

    if (!response.isSuccess) {
      throw Exception('Fehler beim Laden der Gespräche.');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<Map<String, dynamic>> getById({
    required int klientenAkteId,
    required int gespraechId,
  }) async {
    final conversations = await getAll(klientenAkteId: klientenAkteId);

    final conversation = conversations.where((item) {
      return item['id'] == gespraechId;
    }).toList();

    if (conversation.isEmpty) {
      throw Exception('Gespräch nicht gefunden.');
    }

    return conversation.first;
  }

  Future<Map<String, dynamic>> create({
    required int klientenAkteId,
    required String datum,
  }) async {
    final response = await apiClient.post(
      '/users/klientenakten/$klientenAkteId/gespraech',
      body: {
        'datum': datum,
        'formMetaData': {},
        'assessment': {},
        'diagnosen': {},
        'ziele': {},
        'outcome': {},
        'notizen': '',
      },
    );

    if (!response.isSuccess) {
      throw Exception('Fehler beim Speichern des Gesprächs.');
    }

    return Map<String, dynamic>.from(jsonDecode(response.body) as Map);
  }

  Future<Map<String, dynamic>> update({
    required int klientenAkteId,
    required int gespraechId,
    required String datum,
  }) async {
    final existing = await getById(
      klientenAkteId: klientenAkteId,
      gespraechId: gespraechId,
    );

    final response = await apiClient.put(
      '/users/klientenakten/$klientenAkteId/gespraech/$gespraechId',
      body: {
        'datum': datum,
        'formMetaData': existing['formMetaData'] ?? {},
        'assessment': existing['assessment'] ?? {},
        'diagnosen': existing['diagnosen'] ?? {},
        'ziele': existing['ziele'] ?? {},
        'outcome': existing['outcome'] ?? {},
        'notizen': existing['notizen'] ?? '',
      },
    );

    if (!response.isSuccess) {
      throw Exception('Fehler beim Aktualisieren des Gesprächs.');
    }

    return Map<String, dynamic>.from(jsonDecode(response.body) as Map);
  }

  Future<Map<String, dynamic>> updateAssessment({
    required int klientenAkteId,
    required int gespraechId,
    required Map<String, dynamic> assessment,
  }) async {
    final existing = await getById(
      klientenAkteId: klientenAkteId,
      gespraechId: gespraechId,
    );

    final response = await apiClient.put(
      '/users/klientenakten/$klientenAkteId/gespraech/$gespraechId',
      body: {
        'datum': existing['datum'],
        'formMetaData': existing['formMetaData'] ?? {},
        'assessment': assessment,
        'diagnosen': existing['diagnosen'] ?? {},
        'ziele': existing['ziele'] ?? {},
        'outcome': existing['outcome'] ?? {},
        'notizen': existing['notizen'] ?? '',
      },
    );

    if (!response.isSuccess) {
      throw Exception('Fehler beim Speichern des Assessments.');
    }

    return Map<String, dynamic>.from(jsonDecode(response.body) as Map);
  }

  Future<void> delete({
    required int klientenAkteId,
    required int gespraechId,
  }) async {
    final response = await apiClient.delete(
      '/users/klientenakten/$klientenAkteId/gespraech/$gespraechId',
    );

    if (!response.isSuccess) {
      throw Exception('Fehler beim Löschen des Gesprächs.');
    }
  }
}