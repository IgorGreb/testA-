import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_webspark/get_data_model.dart';

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<GetData> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return GetData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
