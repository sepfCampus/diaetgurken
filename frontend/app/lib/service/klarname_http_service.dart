import 'dart:convert';
import 'package:app/data/daos/http/api/api_client.dart';

class KlarnameHttpService {
  final ApiClient apiClient;

  KlarnameHttpService({required this.apiClient});

  Future<String> getKlarname({required String klientenAkteId, required String password}) async {
    final response = await apiClient.post(
      '/users/klientenakten/$klientenAkteId/klarname',
      body: {'password': password},
    );

    if (!response.isSuccess) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Fehler beim Laden des Klarnamens.');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data['name'] as String;
  }
}