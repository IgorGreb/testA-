import 'package:flutter/material.dart';
import 'package:test_webspark/core/const.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double progress;
  final Color color;

  const CustomProgressIndicator({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background circular track
        SizedBox(
          height: Constants.sizedBoxOneHundredFifty,
          width: Constants.sizedBoxOneHundredFifty,
          child: CircularProgressIndicator(
            value: Constants.oneUnits,
            color: Constants.colorBlue,
            strokeWidth: Constants.oneUnits,
          ),
        ),
        // Animated progress indicator
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: Constants.zeroUnits, end: progress),
          duration:
              const Duration(milliseconds: Constants.fiveHundredMilliseconds),
          builder: (context, value, child) {
            return SizedBox(
              height: Constants.sizedBoxOneHundredFifty,
              width: Constants.sizedBoxOneHundredFifty,
              child: CircularProgressIndicator(
                value: value,
                color: color,
                strokeWidth: Constants.treeUnits,
              ),
            );
          },
        ),
        // Progress percentage text
      ],
    );
  }
}
