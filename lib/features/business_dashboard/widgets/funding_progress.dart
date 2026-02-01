import "package:flutter/material.dart";
import "package:capital_commons/shared/dashboard_section.dart";
import "package:capital_commons/models/business.dart";

class FundingProgress extends StatelessWidget {
  final Business business;

  const FundingProgress({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    final current = business.amountRaised.toDouble();
    final goal = business.valuation;
    final progress = goal > 0 ? current / goal : 0.0;
    final sharesRemaining = business.sharesAvailable;
    final sharesSold = business.totalSharesIssued - business.sharesAvailable;

    return DashboardSection(
      title: "Funding Progress",
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Progress bar
          Stack(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2ECC71).withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${_formatCurrency(current)}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2ECC71),
                    ),
                  ),
                  Text(
                    "Raised",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "${(progress * 100).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    "Complete",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${_formatCurrency(goal)}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "Valuation",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Remaining info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(width: 8),
                Text(
                  "\$${_formatCurrency(goal - current)} remaining • $sharesRemaining shares available",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
