import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:marea_sitter/models/dispatch.model.dart';

// const API_URL_BASE = 'http://10.0.2.2:3000';
const API_URL_BASE = 'https://dsrpt.azurewebsites.net';
const Map<String, String> API_HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8'
};

class DispatchRepository {
  Future<Dispatch> getDispatch(int id) async {
    try {
      if (id != null) {
        final response = await http.get('$API_URL_BASE/dispatches/$id');
        if (response.statusCode == 200) {
          return Dispatch.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Dispatch');
        }
      }
    } catch (error) {
      throw Exception('Failed to load Dispatch ' + error);
    }
    return null;
  }

  Future<List<Dispatch>> getDispatchsFromVersionId(versionId) async {
    try {
      final response = await http.get('$API_URL_BASE/dispatches?versionId=$versionId');
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Dispatch.fromJson(i))
            .toList();
      } else {
        throw Exception('Failed to load Dispatch');
      }
    } catch (error) {
      throw Exception('Failed to load Dispatchs' + error.toString());
    }
  }

  Future<List<Dispatch>> getAllDispatchs() async {
    try {
      final response = await http.get('$API_URL_BASE/dispatches');
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Dispatch.fromJson(i))
            .toList();
      } else {
        throw Exception('Failed to load Dispatch');
      }
    } catch (error) {
      throw Exception('Failed to load Dispatchs' + error);
    }
  }

  Future<Dispatch> createDispatch(Dispatch v) async {
    try {
      if (v != null) {
        final response = await http.post(
          '$API_URL_BASE/dispatches',
          headers: API_HEADERS,
          body: jsonEncode(<String, dynamic>{
            'versionId': v.versionId,
            'date': DateTime.now().toString(),
            'quantity': v.quantity
          }),
        );

        if (response.statusCode == 201) {
          return Dispatch.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to create Dispatch');
        }
      }
    } catch (error) {
      throw Exception('Failed to create Dispatch ' + error);
    }
    return null;
  }

  Future<Dispatch> deleteDispatch(int id) async {
    try {
      if (id != null) {
        final response = await http.delete(
          '$API_URL_BASE/dispatches/$id',
          headers: API_HEADERS,
        );
        if (response.statusCode == 200) {
          return Dispatch.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Dispatch');
        }
      }
    } catch (error) {
      throw Exception('Failed delete Dispatch ' + error);
    }
    return null;
  }

  Future<Dispatch> updateDispatch(Dispatch v) async {
    try {
      if (v != null) {
        final response = await http.put(
          '$API_URL_BASE/dispatches/${v.id}',
          headers: API_HEADERS,
          body: jsonEncode(<String, String>{
            'versionId': v.versionId.toString(),
            'date': v.date.toString(),
            'behaviorIds': v.behaviorIds.toString(),
            'quantity': v.quantity.toString()
          }),
        );
        if (response.statusCode == 200) {
          return Dispatch.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Dispatch');
        }
      }
    } catch (error) {
      throw Exception('Failed update Dispatch ' + error.toString());
    }
    return null;
  }
}
