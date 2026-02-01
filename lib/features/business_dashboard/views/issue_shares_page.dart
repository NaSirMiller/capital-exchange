import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";

class IssueSharesPage extends HookWidget {
  const IssueSharesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    final sharesController = useTextEditingController();
    final priceController = useTextEditingController();
    final reasonController = useTextEditingController();

    // ─────────────────────────────────────────────
    // PLACEHOLDER SHARE DATA (replace later)
    // ─────────────────────────────────────────────
    const int totalSharesIssued = 1000;
    const int maxAdditionalSharesAllowed =
        500; // 50% dilution cap (placeholder)
    const int currentSharePrice = 125;
    const int marketCap = totalSharesIssued * currentSharePrice;
    // ─────────────────────────────────────────────

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A1628), Color(0xFF1A2E4A), Color(0xFF0D3B66)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              /// App bar
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
                title: const Text(
                  "Issue More Shares",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              /// Content
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 40 : (isTablet ? 24 : 16),
                  vertical: 24,
                ),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: isDesktop ? 600 : double.infinity,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Header
                          const Text(
                            "Raise Additional Capital",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Issue additional shares to raise more funding for your business",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.7),
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 32),

                          /// Current info card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Share Status",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _InfoRow(
                                  label: "Total Shares Issued",
                                  value: totalSharesIssued.toString(),
                                ),
                                const SizedBox(height: 8),
                                _InfoRow(
                                  label: "Current Share Price",
                                  value: "\$$currentSharePrice",
                                ),
                                const SizedBox(height: 8),
                                _InfoRow(
                                  label: "Market Cap",
                                  value: "\$$marketCap",
                                ),
                                const SizedBox(height: 8),
                                _InfoRow(
                                  label: "Max Additional Shares Allowed",
                                  value: maxAdditionalSharesAllowed.toString(),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          /// Form
                          _InputField(
                            controller: sharesController,
                            label:
                                "Number of Additional Shares (Max $maxAdditionalSharesAllowed)",
                            icon: Icons.pie_chart_outline,
                            keyboardType: TextInputType.number,
                          ),

                          const SizedBox(height: 16),

                          _InputField(
                            controller: priceController,
                            label: "Price Per Share (\$)",
                            icon: Icons.attach_money,
                            keyboardType: TextInputType.number,
                          ),

                          const SizedBox(height: 16),

                          _InputField(
                            controller: reasonController,
                            label: "Reason for Additional Funding",
                            icon: Icons.description_outlined,
                            maxLines: 4,
                          ),

                          const SizedBox(height: 24),

                          /// Info banner
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF39C12).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFF39C12).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: Color(0xFFF39C12),
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "New shares will dilute existing shareholders. Investors will be notified.",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          /// Submit button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                final requestedShares =
                                    int.tryParse(sharesController.text) ?? 0;

                                if (requestedShares >
                                    maxAdditionalSharesAllowed) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Requested shares exceed the maximum allowed.",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                // TODO: handle share issuance
                                context.pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2ECC71),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Issue Shares",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// Input Field
/// ─────────────────────────────────────────────
class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.35),
            fontSize: 15,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Icon(icon, color: Colors.white38, size: 20),
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// Info Row
/// ─────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7)),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
