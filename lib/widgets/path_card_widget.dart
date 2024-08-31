import 'package:flutter/material.dart';

class PathCardWidget extends StatelessWidget {
  const PathCardWidget({super.key, required this.path, required this.click});
  final String path;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 1.0),
          ),
        ),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
          path,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
