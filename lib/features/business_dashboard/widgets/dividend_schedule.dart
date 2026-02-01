import "package:flutter/material.dart";
import "package:capital_commons/shared/dashboard_section.dart";
import "package:capital_commons/models/business.dart";

class DividendSchedule extends StatelessWidget {
  final Business business;

  const DividendSchedule({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    final totalRaised = business.amountRaised.toDouble();
    final dividendPercentage = business.dividendPercentage;
    final totalPayout = totalRaised * (dividendPercentage / 100);
    final perShareDividend = business.totalSharesIssued > 0
        ? totalPayout / business.totalSharesIssued
        : 0.0;
    final numInvestors = business.numInvestors;

    // Calculate next dividend date (placeholder - you can store this in Firestore)
    final now = DateTime.now();
    final nextQuarter = DateTime(
      now.month <= 3 ? now.year : now.year + (now.month > 9 ? 1 : 0),
      ((now.month - 1) ~/ 3 + 1) * 3 + 1,
      1,
    );
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final nextDividendDate =
        "${months[nextQuarter.month - 1]} ${nextQuarter.day}, ${nextQuarter.year}";

    return DashboardSection(
      title: "Next Dividend",
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Next payment card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4A90D9).withOpacity(0.2),
                  const Color(0xFF4A90D9).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF4A90D9).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xFF4A90D9),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      nextDividendDate,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "\$${_formatCurrency(totalPayout)}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A90D9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Total Payout (${dividendPercentage.toStringAsFixed(1)}% of \$${_formatCurrency(totalRaised)})",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Details
          _DetailRow(label: "Payment Frequency", value: "Quarterly"),
          const SizedBox(height: 8),
          _DetailRow(
            label: "Per Share Dividend",
            value: "\$${perShareDividend.toStringAsFixed(2)}",
          ),
          const SizedBox(height: 8),
          _DetailRow(
            label: "Shareholders",
            value: "$numInvestors investor${numInvestors != 1 ? 's' : ''}",
          ),

          const SizedBox(height: 16),

          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71).withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF2ECC71).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF2ECC71),
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  "On Track • Profits reported",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2ECC71),
                    fontWeight: FontWeight.w600,
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6)),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
