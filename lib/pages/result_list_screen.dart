import 'package:flutter/material.dart';
import 'package:test_webspark/path_finder.dart';

class ResultListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const ResultListScreen({
    super.key,
    required this.data,
  });

  void _onTileTapped(BuildContext context, String start, String end) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PathFinderPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.blue,
        title: const Text(
          'Result Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            final start = '(${item['start']['x']}, ${item['start']['y']})';
            final end = '(${item['end']['x']}, ${item['end']['y']})';

            return ListTile(
              subtitle: InkWell(
                onTap: () => _onTileTapped(context, start, end),
                child: Center(
                  child: Text(
                    '$start -> $end',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
