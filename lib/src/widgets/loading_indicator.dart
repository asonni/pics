import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double width, height, strokeWidth;
  final Color color;

  const LoadingIndicator({
    super.key,
    this.width = 25,
    this.height = 25,
    this.color = Colors.white,
    this.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color,
      ),
    );
  }
}
