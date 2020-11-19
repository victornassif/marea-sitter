import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/version.model.dart';

const API_URL_BASE = 'http://10.0.2.2:3000';
const Map<String, String> API_HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8'
};

class VersionRepository {
  Future<Version> getVersion(int id) async {
    try {
      if (id != null) {
        final response = await http.get('$API_URL_BASE/robotVersions/$id');
        if (response.statusCode == 200) {
          return Version.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Version');
        }
      }
    } catch (error) {
      throw Exception('Failed to load Version ' + error);
    }
    return null;
  }

  Future<List<Version>> getAllVersions() async {
    try {
      final response = await http.get('$API_URL_BASE/robotVersions');
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Version.fromJson(i))
            .toList();
      } else {
        throw Exception('Failed to load Version');
      }
    } catch (error) {
      throw Exception('Failed to load Versions' + error);
    }
  }

  Future<Version> createVersion(Version v) async {
    try {
      if (v != null) {
        final response = await http.post(
          '$API_URL_BASE/robotVersions',
          headers: API_HEADERS,
          body: jsonEncode(
              <String, String>{'title': v.title, 'description': v.description}),
        );

        if (response.statusCode == 201) {
          return Version.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to create Version');
        }
      }
    } catch (error) {
      throw Exception('Failed to create Version ' + error);
    }
    return null;
  }

  Future<Version> deleteVersion(int id) async {
    try {
      if (id != null) {
        final response = await http.delete(
          '$API_URL_BASE/robotVersions/$id',
          headers: API_HEADERS,
        );
        if (response.statusCode == 200) {
          return Version.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Version');
        }
      }
    } catch (error) {
      throw Exception('Failed delete Version ' + error);
    }
    return null;
  }

  Future<Version> updateVersion(Version v) async {
    try {
      if (v != null) {
        final response = await http.put(
          '$API_URL_BASE/robotVersions/${v.id}',
          headers: API_HEADERS,
          body: jsonEncode(<String, String>{
            'title': v.title,
            'description': v.description,
          }),
        );
        if (response.statusCode == 200) {
          return Version.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Version');
        }
      }
    } catch (error) {
      throw Exception('Failed update Version ' + error.toString());
    }
    return null;
  }
}
