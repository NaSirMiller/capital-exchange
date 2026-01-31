import "package:capital_commons/core/app.dart";
import "package:capital_commons/core/service_locator.dart";
import "package:flutter/material.dart";

void main() async {
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CapitalCommonsApp();
  }
}
