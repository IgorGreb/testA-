import 'package:flutter/material.dart';
import 'package:test_webspark/core/const.dart';
import 'package:test_webspark/widgets/path_card_widget.dart';
import 'package:test_webspark/widgets/path_finder.dart';

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
          field: const {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colorWhite,
      appBar: AppBar(
        shadowColor: Constants.colorBlack,
        backgroundColor: Constants.colorBlue,
        title: Text(
          Constants.resultScreenText,
          style: TextStyle(color: Constants.colorWhite),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          final start = '(${item['start']['x']}, ${item['start']['y']})';
          final end = '(${item['end']['x']}, ${item['end']['y']})';

          return PathCardWidget(
            path: '$start -> $end',
            click: () => _onTileTapped(context, item),
          );
        },
      ),
    );
  }
}
