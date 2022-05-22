import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class API {
  // Fetch content from the json file
  Future<String> readLocalJson() async {
    final String response = await rootBundle.loadString('data.json');
    return response;
  }

  // Fetch content from fake api
  Future<String> readApiJson() async {
    final response = await http.get(Uri.parse("${(apiUrl)}$token"));
    if(response.body.isEmpty) {
      return readLocalJson();
    }
    return response.body;
  }
}