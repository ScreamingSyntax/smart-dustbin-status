import 'dart:convert';

// import '../Models/status_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://smart-dustbin-api.onrender.com/";
  Future<int> getStatus() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception("Failed to load data from APi");
    }
  }
}
