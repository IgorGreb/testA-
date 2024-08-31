import 'package:flutter/material.dart';
import 'package:test_webspark/core/const.dart';

class PathCardWidget extends StatelessWidget {
  const PathCardWidget({super.key, required this.path, required this.click});
  final String path;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Constants.colorBlack,
              width: Constants.oneUnits,
            ),
          ),
        ),
        height: Constants.fiftyDotZero,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
          path,
          style: const TextStyle(
            fontSize: Constants.fifteenUnits,
          ),
        )),
      ),
    );
  }
}
