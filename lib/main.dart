import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_webspark/pages/result_list_screen.dart';
import 'package:test_webspark/widgets/loadind_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Home Screen',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController(
      text:
          'https://your-api-endpoint.com/tasks'); // Replace with your API endpoint
  String _apiUrl =
      'https://your-api-endpoint.com/tasks'; // Replace with your API endpoint
  String? _errorMessage; // State variable to hold error messages

  @override
  void initState() {
    super.initState();
    _loadSavedUrl();
  }

  // Load saved URL from shared preferences
  Future<void> _loadSavedUrl() async {
    // Implement loading the URL from shared preferences if needed
  }

  // Function to validate the URL
  bool _isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && uri.hasScheme && uri.hasAuthority;
  }

  Future<Map<String, dynamic>?> _fetchDataFromServer(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Server Response: ${response.body}');
        }
        // Ensure that the response body is a Map<String, dynamic>
        return json.decode(response.body) as Map<String, dynamic>?;
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status: ${response.statusCode}');
        }
        return null; // Or handle the error accordingly
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return null; // Or handle the error accordingly
    }
  }

  Future<void> _startProcess() async {
    if (_isValidUrl(_urlController.text)) {
      _apiUrl = _urlController.text;

      // Show the LoadindPage with a progress indicator
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoadindPage(
                  fetchData: _fetchDataFromServer(_apiUrl),
                )),
      );

      // If data is returned, navigate to the ResultListScreen with the data
      if (result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultListScreen(
                    key: result, data: const [], // Pass the result data
                  )),
        );
      }
    } else {
      setState(() {
        _errorMessage = 'Please enter a valid URL.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.blue,
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Set valid API base URL to fetch tasks',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: TextField(
              controller: _urlController,
              decoration: InputDecoration(
                errorText: _errorMessage,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 40,
              width: 300,
              child: TextButton(
                onPressed: _startProcess,
                child: const Text(
                  'Start Counting Process',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
