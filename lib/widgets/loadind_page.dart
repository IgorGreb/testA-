import 'package:flutter/material.dart';
import 'package:test_webspark/pages/result_list_screen.dart';

class LoadindPage extends StatefulWidget {
  final Future<Map<String, dynamic>?> fetchData;

  const LoadindPage({super.key, required this.fetchData});

  @override
  State<LoadindPage> createState() => _LoadindPageState();
}

class _LoadindPageState extends State<LoadindPage> {
  double _progress = 0.0;
  List<Map<String, dynamic>>? _data; // Updated to List<Map<String, dynamic>> for multiple results
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startFetching();
  }

  Future<void> _startFetching() async {
    setState(() {
      _progress = 0.0; // Start progress
    });

    try {
      final data = await widget.fetchData;
      setState(() {
        _progress = 1.0; // End progress
        if (data != null &&
            data['error'] == false &&
            data.containsKey('data') &&
            data['data'] is List) {
          _data = List<Map<String, dynamic>>.from(data['data']);
        } else {
          _errorMessage = 'Invalid server response or error in response data.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching data: $e';
      });
    }
  }

  void _navigateToResultScreen() {
    if (_data != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultListScreen(data: _data!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No data available to send.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Process screen', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Display final message
          if (_progress >= 1.0 && _data != null)
            const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'All calculations have finished, you can send\n your result to the server.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
          // Display animated percentage text
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: _progress * 100),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Text(
                '${value.toStringAsFixed(0)}%',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          Container(
            height: 0.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          const SizedBox(height: 100),
          // Display progress indicator
          if (_progress < 1.0 || _data == null)
            Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  value: _progress,
                  strokeWidth: 4.0,
                ),
              ),
            ),
          // Show error message if there was an issue
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          // Send result button - Only display if progress is complete
          if (_progress >= 1.0 && _data != null)
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 40,
              width: 300,
              child: Center(
                child: TextButton(
                  onPressed: _navigateToResultScreen,
                  child: const Text(
                    'Send result to server',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
