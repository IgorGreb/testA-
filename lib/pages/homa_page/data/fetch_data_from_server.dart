import 'dart:convert'; // Для json.decode
import 'package:http/http.dart' as http; // Для http.get
import 'package:flutter/foundation.dart'; // Для kDebugMode

Future<Map<String, dynamic>?> fetchDataFromServer(String url) async {
  try {
    // Надсилаємо GET-запит до вказаного URL
    final response = await http.get(Uri.parse(url));

    // Перевіряємо статус відповіді
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Server Response: ${response.body}');
      }
      // Повертаємо розкодовану відповідь JSON
      return json.decode(response.body) as Map<String, dynamic>?;
    } else {
      // У випадку помилки відповіді, виводимо статус
      if (kDebugMode) {
        print('Failed to fetch data. Status: ${response.statusCode}');
      }
      return null;
    }
  } catch (e) {
    // У випадку винятка, виводимо помилку
    if (kDebugMode) {
      print('Error fetching data: $e');
    }
    return null;
  }
}
