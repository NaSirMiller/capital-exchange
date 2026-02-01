import "package:flutter/material.dart";
import "../../../models/portfolio.dart";
import "shared/metric_card.dart";

class PortfolioOverview extends StatelessWidget {
  final Portfolio? portfolio;

  const PortfolioOverview({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    if (portfolio == null) return const SizedBox();

    return Row(
      children: [
        Expanded(
          child: MetricCard(
            label: "Total Value",
            value: "\$${portfolio!.totalValue.toStringAsFixed(0)}",
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MetricCard(
            label: "Total Return",
            value: "\$${portfolio!.totalReturn.toStringAsFixed(0)}",
          ),
        ),
      ],
    );
  }
}
