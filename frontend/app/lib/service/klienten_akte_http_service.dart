import 'dart:convert';
import 'package:app/data/daos/http/api/api_client.dart';

class KlientenAkteHttpService {
  final ApiClient apiClient;

  KlientenAkteHttpService({required this.apiClient});

  Future<List<Map<String, dynamic>>> getAll() async {
    final response = await apiClient.get('/users/klientenakten');

    if (!response.isSuccess) {
      throw Exception('Fehler beim Laden der Klientenakten.');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<void> create({required String name}) async {
    final response = await apiClient.post('/users/klientenakte', body: {
      'name': name,
    });

    if (!response.isSuccess) {
      throw Exception('Fehler beim Anlegen der Klientenakte.');
    }
  }

  Future<void> delete({required int id}) async {
    final response = await apiClient.delete('/users/klientenakten/$id');

    if (!response.isSuccess) {
      throw Exception('Fehler beim Löschen der Klientenakte.');
    }
  }
}