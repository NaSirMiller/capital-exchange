import "package:flutter/material.dart";

class DashboardHeader extends StatelessWidget {
  final String businessName;

  const DashboardHeader({super.key, this.businessName = "Your Business"});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome, $businessName 👋",
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Here's an overview of your business performance",
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6)),
        ),
      ],
    );
  }
}
