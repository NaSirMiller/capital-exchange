import "package:capital_commons/core/logger.dart";
import "package:capital_commons/models/holding.dart";
import "package:capital_commons/repositories/holdings_repository.dart";
import "package:capital_commons/core/service_locator.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:capital_commons/shared/dashboard_section.dart";
import "package:capital_commons/shared/investor_row.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class InvestorList extends HookWidget {
  final String businessId;

  const InvestorList({super.key, required this.businessId});

  @override
  Widget build(BuildContext context) {
    final investorsState = useState<List<Map<String, dynamic>>>([]);
    final isLoading = useState(true);

    useEffect(() {
      Future<void> loadInvestors() async {
        try {
          final firestore = FirebaseFirestore.instance;

          // Get all holdings for this business from all portfolios
          final holdingsSnapshot = await firestore
              .collectionGroup('holdings')
              .where('businessId', isEqualTo: businessId)
              .orderBy('createdAt', descending: true)
              .limit(5)
              .get();

          final investors = <Map<String, dynamic>>[];

          for (final doc in holdingsSnapshot.docs) {
            try {
              final data = doc.data();
              final holding = Holding.fromJson(data);

              // Get investor name from user info
              final investorId = holding.investorId;
              String investorName = "Anonymous Investor";

              if (investorId != null) {
                try {
                  final userDoc = await firestore
                      .collection('user_info')
                      .doc(investorId)
                      .get();

                  if (userDoc.exists) {
                    final userData = userDoc.data();
                    final firstName = userData?['firstName'] ?? '';
                    final lastName = userData?['lastName'] ?? '';
                    if (firstName.isNotEmpty || lastName.isNotEmpty) {
                      investorName = '$firstName $lastName'.trim();
                    }
                  }
                } catch (e) {
                  Log.warning("Could not fetch investor name: $e");
                }
              }

              // Calculate time ago
              final createdAt = holding.createdAt ?? DateTime.now();
              final timeAgo = _getTimeAgo(createdAt);

              // Calculate amount invested
              final amount = holding.numShares * holding.sharePrice;

              investors.add({
                "name": investorName,
                "shares": holding.numShares,
                "date": timeAgo,
                "amount": "\$${amount.toStringAsFixed(2)}",
              });
            } catch (e) {
              Log.warning("Error parsing holding: $e");
            }
          }

          investorsState.value = investors;
        } catch (e) {
          Log.error("Error loading investors: $e");
        } finally {
          isLoading.value = false;
        }
      }

      loadInvestors();
      return null;
    }, [businessId]);

    if (isLoading.value) {
      return DashboardSection(
        title: "Recent Investors",
        child: Container(
          height: 200,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(color: Color(0xFF4A90D9)),
        ),
      );
    }

    if (investorsState.value.isEmpty) {
      return DashboardSection(
        title: "Recent Investors",
        child: Container(
          height: 120,
          alignment: Alignment.center,
          child: Text(
            "No investors yet",
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
          ),
        ),
      );
    }

    return DashboardSection(
      title: "Recent Investors",
      action: TextButton(
        onPressed: () {
          // TODO: Navigate to full investor list
        },
        child: const Text(
          "View All",
          style: TextStyle(color: Color(0xFF4A90D9), fontSize: 13),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          ...investorsState.value.map(
            (investor) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InvestorRow(
                name: investor["name"] as String,
                shares: investor["shares"] as int,
                date: investor["date"] as String,
                amount: investor["amount"] as String,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return "$years year${years != 1 ? 's' : ''} ago";
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return "$months month${months != 1 ? 's' : ''} ago";
    } else if (difference.inDays > 0) {
      return "${difference.inDays} day${difference.inDays != 1 ? 's' : ''} ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hour${difference.inHours != 1 ? 's' : ''} ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minute${difference.inMinutes != 1 ? 's' : ''} ago";
    } else {
      return "Just now";
    }
  }
}
