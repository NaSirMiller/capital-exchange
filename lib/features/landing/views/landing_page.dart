import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Capital Exchange"),
            TextButton(
              onPressed: () {
                context.go("/signup");
              },
              child: const Text("Sign Up"),
            ),
            TextButton(
              onPressed: () {
                context.go("/login");
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
