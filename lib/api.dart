import 'dart:math';

import 'package:api_sample_project/endpoints.dart';
import 'package:api_sample_project/models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<User>?> getUsers() async {
    try {
      final url = Uri.parse(Endpoints.baseUrl + Endpoints.usersEndpoint);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<User> _users = userFromJson(response.body);
        return _users;
      }
    } catch (e) {
      // we will print the error if it happens
    }
  }
}
