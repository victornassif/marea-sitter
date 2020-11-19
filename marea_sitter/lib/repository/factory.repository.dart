import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/factory.model.dart';

const API_URL_BASE = 'http://10.0.2.2:3000';
const Map<String, String> API_HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8'
};

class FactoryRepository {
  Future<Factory> getFactory(int id) async {
    try {
      if (id != null) {
        final response = await http.get('$API_URL_BASE/factoryes/$id');
        if (response.statusCode == 200) {
          return Factory.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Factory');
        }
      }
    } catch (error) {
      throw Exception('Failed to load Factory ' + error);
    }
    return null;
  }

  Future<List<Factory>> getAllFactorys() async {
    try {
      final response = await http.get('$API_URL_BASE/factoryes');
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Factory.fromJson(i))
            .toList();
      } else {
        throw Exception('Failed to load Factory');
      }
    } catch (error) {
      throw Exception('Failed to load Factorys' + error);
    }
  }

  Future<Factory> createFactory(Factory v) async {
    try {
      if (v != null) {
        final response = await http.post(
          '$API_URL_BASE/factoryes',
          headers: API_HEADERS,
          body: jsonEncode(<String, dynamic>{
            'versaoId': v.versaoId,
            'tempoConclusao': v.tempoConclusao,
            'dataCriacao': DateTime.now().toString(),
            'quantidadeRobos': v.quantidadeRobos,
          }),
        );

        if (response.statusCode == 201) {
          return Factory.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to create Factory');
        }
      }
    } catch (error) {
      throw Exception('Failed to create Factory ' + error);
    }
    return null;
  }

  Future<Factory> deleteFactory(int id) async {
    try {
      if (id != null) {
        final response = await http.delete(
          '$API_URL_BASE/factoryes/$id',
          headers: API_HEADERS,
        );
        if (response.statusCode == 200) {
          return Factory.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Factory');
        }
      }
    } catch (error) {
      throw Exception('Failed delete Factory ' + error);
    }
    return null;
  }

  Future<Factory> updateFactory(Factory v) async {
    try {
      if (v != null) {
        final response = await http.put(
          '$API_URL_BASE/factoryes/${v.id}',
          headers: API_HEADERS,
          body: jsonEncode(<String, String>{
            'versaoId': v.versaoId.toString(),
            'tempoConclusao': v.tempoConclusao.toString(),
            'dataCriacao': v.dataCriacao.toString(),
            'quantidadeRobos': v.quantidadeRobos.toString(),
          }),
        );
        if (response.statusCode == 200) {
          return Factory.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load Factory');
        }
      }
    } catch (error) {
      throw Exception('Failed update Factory ' + error.toString());
    }
    return null;
  }
}
