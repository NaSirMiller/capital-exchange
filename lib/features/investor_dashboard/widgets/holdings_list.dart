import "package:flutter/material.dart";
import "../../../models/holding.dart";
import "holding_row.dart";
import "shared/dashboard_section.dart";

class HoldingsList extends StatelessWidget {
  final List<Holding> holdings;

  const HoldingsList({super.key, required this.holdings});

  @override
  Widget build(BuildContext context) {
    return DashboardSection(
      title: "Your Holdings",
      child: Column(
        children: holdings.map((h) => HoldingRow(holding: h)).toList(),
      ),
    );
  }
}
