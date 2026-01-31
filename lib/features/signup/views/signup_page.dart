import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("What are you? 😏"),
            TextButton(
              onPressed: () {
                context.go("/signup/investor");
              },
              child: const Text("Investor"),
            ),
            TextButton(
              onPressed: () {
                context.go("/signup/business");
              },
              child: const Text("Business"),
            ),
          ],
        ),
      ),
    );
  }
}
