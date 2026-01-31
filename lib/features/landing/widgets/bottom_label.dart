import "package:flutter/material.dart";

class BottomLabel extends StatelessWidget {
  const BottomLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          "Capital Region • Community Driven",
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.4),
            letterSpacing: 2.0,
            fontWeight: FontWeight.w400,
            shadows: const [
              Shadow(
                blurRadius: 8,
                color: Colors.black54,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
