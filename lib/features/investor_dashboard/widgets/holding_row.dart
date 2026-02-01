import "package:flutter/material.dart";
import "../../../models/holding.dart";

class HoldingRow extends StatelessWidget {
  final Holding holding;

  const HoldingRow({super.key, required this.holding});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        holding.businessName,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        "${holding.shares} shares • ${holding.dividendYield}%",
        style: TextStyle(color: Colors.white.withOpacity(0.6)),
      ),
      trailing: Text(
        "\$${holding.value.toStringAsFixed(0)}",
        style: const TextStyle(
          color: Color(0xFF4A90D9),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
