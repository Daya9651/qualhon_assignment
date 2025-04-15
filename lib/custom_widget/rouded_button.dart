import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Icon? icon;
  final Color? color;

  const RoundButton({
    super.key,
    this.color,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? Colors.purple;

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: loading
                ? CircularProgressIndicator(
                strokeWidth: 3, color: Colors.white)
                : Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}