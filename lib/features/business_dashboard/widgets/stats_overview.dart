import "package:flutter/material.dart";
import "package:capital_commons/shared/metric_card.dart";
import "package:capital_commons/models/business.dart";

class StatsOverview extends StatelessWidget {
  final Business business;

  const StatsOverview({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768;

    // Calculate stats from business data
    final totalRaised = business.amountRaised.toDouble();
    final goal = business.valuation;
    final percentOfGoal = goal > 0 ? (totalRaised / goal * 100) : 0.0;
    final numInvestors = business.numInvestors;
    final sharePrice = business.sharePrice;
    final marketCap = business.totalSharesIssued * sharePrice;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (isDesktop) {
          return Row(
            children: [
              Expanded(
                child: MetricCard(
                  title: "Total Raised",
                  value: "\$${_formatCurrency(totalRaised)}",
                  subtitle: "${percentOfGoal.toStringAsFixed(1)}% of goal",
                  icon: Icons.account_balance_wallet_outlined,
                  color: const Color(0xFF2ECC71),
                  trend: "+\$12.5K", // TODO: Calculate actual trend
                  trendPositive: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MetricCard(
                  title: "Investors",
                  value: "$numInvestors",
                  subtitle: "Active shareholders",
                  icon: Icons.people_outline,
                  color: const Color(0xFF4A90D9),
                  trend: "+3 this week", // TODO: Calculate actual trend
                  trendPositive: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MetricCard(
                  title: "Share Price",
                  value: "\$${sharePrice.toStringAsFixed(2)}",
                  subtitle: "Current market value",
                  icon: Icons.show_chart,
                  color: const Color(0xFFE74C3C),
                  trend: "Stable", // TODO: Calculate actual trend
                  trendPositive: null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MetricCard(
                  title: "Market Cap",
                  value: "\$${_formatCurrency(marketCap)}",
                  subtitle: "${business.totalSharesIssued} total shares",
                  icon: Icons.pie_chart_outline,
                  color: const Color(0xFF9B59B6),
                  trend: "Fully diluted",
                  trendPositive: null,
                ),
              ),
            ],
          );
        } else if (isTablet) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      title: "Total Raised",
                      value: "\$${_formatCurrency(totalRaised)}",
                      subtitle: "${percentOfGoal.toStringAsFixed(1)}% of goal",
                      icon: Icons.account_balance_wallet_outlined,
                      color: const Color(0xFF2ECC71),
                      trend: "+\$12.5K",
                      trendPositive: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MetricCard(
                      title: "Investors",
                      value: "$numInvestors",
                      subtitle: "Active shareholders",
                      icon: Icons.people_outline,
                      color: const Color(0xFF4A90D9),
                      trend: "+3 this week",
                      trendPositive: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      title: "Share Price",
                      value: "\$${sharePrice.toStringAsFixed(2)}",
                      subtitle: "Current market value",
                      icon: Icons.show_chart,
                      color: const Color(0xFFE74C3C),
                      trend: "Stable",
                      trendPositive: null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MetricCard(
                      title: "Market Cap",
                      value: "\$${_formatCurrency(marketCap)}",
                      subtitle: "${business.totalSharesIssued} total shares",
                      icon: Icons.pie_chart_outline,
                      color: const Color(0xFF9B59B6),
                      trend: "Fully diluted",
                      trendPositive: null,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: [
              MetricCard(
                title: "Total Raised",
                value: "\$${_formatCurrency(totalRaised)}",
                subtitle: "${percentOfGoal.toStringAsFixed(1)}% of goal",
                icon: Icons.account_balance_wallet_outlined,
                color: const Color(0xFF2ECC71),
                trend: "+\$12.5K",
                trendPositive: true,
              ),
              const SizedBox(height: 12),
              MetricCard(
                title: "Investors",
                value: "$numInvestors",
                subtitle: "Active shareholders",
                icon: Icons.people_outline,
                color: const Color(0xFF4A90D9),
                trend: "+3 this week",
                trendPositive: true,
              ),
              const SizedBox(height: 12),
              MetricCard(
                title: "Share Price",
                value: "\$${sharePrice.toStringAsFixed(2)}",
                subtitle: "Current market value",
                icon: Icons.show_chart,
                color: const Color(0xFFE74C3C),
                trend: "Stable",
                trendPositive: null,
              ),
              const SizedBox(height: 12),
              MetricCard(
                title: "Market Cap",
                value: "\$${_formatCurrency(marketCap)}",
                subtitle: "${business.totalSharesIssued} total shares",
                icon: Icons.pie_chart_outline,
                color: const Color(0xFF9B59B6),
                trend: "Fully diluted",
                trendPositive: null,
              ),
            ],
          );
        }
      },
    );
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return "${(amount / 1000000).toStringAsFixed(1)}M";
    } else if (amount >= 1000) {
      return "${(amount / 1000).toStringAsFixed(1)}K";
    } else {
      return amount.toStringAsFixed(0);
    }
  }
}
