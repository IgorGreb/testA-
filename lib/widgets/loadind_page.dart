import 'package:flutter/material.dart';
import 'package:test_webspark/pages/result_list_screen.dart';
import 'package:test_webspark/widgets/custom_progress_indicator.dart';

class LoadingPage extends StatefulWidget {
  final Future<Map<String, dynamic>?> fetchData;

  const LoadingPage({super.key, required this.fetchData});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double _progress = 0.0;
  List<Map<String, dynamic>>? _data;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startFetching();
  }

  Future<void> _startFetching() async {
    setState(() {
      _progress = 0.0; // Start progress
      _errorMessage = null; // Clear previous error message
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
          _progress = 0.0; // Reset progress if there's an error
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching data: $e';
        _progress = 0.0; // Reset progress if there's an error
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
        const SnackBar(content: Text('No data available to send.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:
            const Text('Process Screen', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the completion message only if progress is complete and data is available
            if (_progress == 1.0 && _data != null)
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'All calculations have finished, you can send\n your result to the server.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            // Display animated percentage text only if there's no error
            if (_errorMessage == null)
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
            const SizedBox(height: 20),
            // Progress bar separator
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 20),
            // Display progress indicator while loading and no error
            Center(
              child: CustomProgressIndicator(
                progress: _progress,
                color: Colors.blue,
              ),
            ),
            // Display error message if there is one
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
            // Display send result button only if progress is complete and data is available
            if (_progress == 1.0 && _data != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
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
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
