import "package:flutter/material.dart";

extension ShowSnackbarMessage on BuildContext {
  void showSnackbarMessage(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(
      this,
    ).showSnackBar(SnackBar(content: Text(message), duration: duration));
  }
}
