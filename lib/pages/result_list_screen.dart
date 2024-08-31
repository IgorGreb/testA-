import 'package:flutter/material.dart';
import 'package:test_webspark/path_finder.dart';

class ResultListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const ResultListScreen({
    super.key,
    required this.data,
  });

  void _onTileTapped(BuildContext context, Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PathFinderPage(
          start: item['start'],
          end: item['end'],
          field: {},
        ),
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
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          final start = '(${item['start']['x']}, ${item['start']['y']})';
          final end = '(${item['end']['x']}, ${item['end']['y']})';

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              borderOnForeground: false,
              color: Colors.white,
              child: InkWell(
                onTap: () => _onTileTapped(context, item),
                child: Center(
                  child: Text(
                    '$start -> $end',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
