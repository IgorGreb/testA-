import 'package:flutter/material.dart';

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
        const SizedBox(
          height: 150,
          width: 150,
          child: CircularProgressIndicator(
            value: 1.0,
            color: Colors.blue,
            strokeWidth: 1.0,
          ),
        ),
        // Animated progress indicator
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: progress),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return SizedBox(
              height: 150,
              width: 150,
              child: CircularProgressIndicator(
                value: value,
                color: color,
                strokeWidth: 3.0,
              ),
            );
          },
        ),
        // Progress percentage text
       
      ],
    );
  }
}
