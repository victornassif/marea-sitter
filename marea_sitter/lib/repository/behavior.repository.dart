import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/behavior.model.dart';

const API_URL_BASE = 'http://10.0.2.2:3000';
const Map<String, String> API_HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8'
};

class BehaviorRepository{
  
  Future<Behavior> getBehavior(int id) async {
    try {
      if (id != null) {
        final response = await http.get('$API_URL_BASE/behaviors/$id');
        if (response.statusCode == 200) {
          return Behavior.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Behavior');
        }
      }
    } catch (error) {
      throw Exception('Failed to load Behavior ' + error);
    }
    return null;
  }

  Future<List<Behavior>> getAllBehaviors() async {
    try {
      final response = await http.get('$API_URL_BASE/behaviors');
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Behavior.fromJson(i))
            .toList();
      } else {
        throw Exception('Failed to load Behavior');
      }
    } catch (error) {
      throw Exception('Failed to load Behaviors' + error);
    }
  }

  
  Future<Behavior> createBehavior(Behavior v) async {
    try {
      if (v != null) {
        final response = await http.post(
          '$API_URL_BASE/behaviors',
          headers: API_HEADERS,
          body: jsonEncode(<String, String>{
            'title': v.title,
            'description': v.description
          }),
        );

        if (response.statusCode == 201) {
          return Behavior.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to create Behavior');
        }
      }
    } catch (error) {
      throw Exception('Failed to create Behavior ' + error);
    }
    return null;
  }

  
  Future<Behavior> deleteBehavior(int id) async {
    try {
      if (id != null) {
        final response = await http.delete(
          '$API_URL_BASE/behaviors/$id',
          headers: API_HEADERS,
        );
        if (response.statusCode == 200) {
          return Behavior.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Behavior');
        }
      }
    } catch (error) {
      throw Exception('Failed delete Behavior ' + error);
    }
    return null;
  }

  
  Future<Behavior> updateBehavior(Behavior v) async {
    try {
      if (v != null) {
        final response = await http.put(
          '$API_URL_BASE/behaviors/${v.id}',
          headers: API_HEADERS,
          body: jsonEncode(<String, String>{
            'title': v.title,
            'description': v.description,
          }),
        );
        if (response.statusCode == 200) {
          return Behavior.fromJson(
            json.decode(
              response.body)
              );
        } else {
          throw Exception('Failed to load Behavior');
        }
      }
    } catch (error) {
      throw Exception('Failed update Behavior ' + error.toString());
    }
    return null;
  }
}