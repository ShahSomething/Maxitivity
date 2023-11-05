import 'package:flutter/material.dart';

class CircularFilledButton extends StatelessWidget {
  const CircularFilledButton({
    super.key,
    required this.color,
    required this.text,
    this.onPressed,
    this.padding = 30,
    this.fontSize,
  });
  final Color color;
  final String text;
  final VoidCallback? onPressed;
  final double padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color.withOpacity(0.3),
        shape: const CircleBorder(),
        padding: EdgeInsets.all(padding),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color, fontWeight: FontWeight.bold, fontSize: fontSize),
      ),
    );
  }
}
