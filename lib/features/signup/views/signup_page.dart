import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [
              Color(0xFF0A1628),
              Color(0xFF1A2E4A),
              Color(0xFF0D3B66),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background glow circles
            Positioned(
              top: -80,
              right: -60,
              child: _GlowCircle(
                size: 250,
                color: const Color(0xFF4A90D9).withOpacity(0.08),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.15,
              left: -100,
              child: _GlowCircle(
                size: 300,
                color: const Color(0xFF2ECC71).withOpacity(0.06),
              ),
            ),

            // Back button
            Positioned(
              top: 56,
              left: 20,
              child: IconButton(
                onPressed: () => context.go("/"),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white70,
                  size: 22,
                ),
              ),
            ),

            // Main content
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: screenWidth >= 768 ? 520 : 400,
                    ),
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF4A90D9).withOpacity(0.4),
                              width: 2,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: const [
                                Color(0xFF1A3A5C),
                                Color(0xFF0D2137),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.trending_up_rounded,
                              color: Color(0xFF4A90D9),
                              size: 26,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Title
                        const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        // Subtitle
                        Text(
                          "Tell us who you are",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.6),
                            letterSpacing: 0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 40),

                        // Investor option
                        _SignupOption(
                          label: "Investor",
                          description: "Looking to invest in vetted businesses",
                          icon: Icons.account_balance_wallet_outlined,
                          onTap: () => context.go("/signup/investor"),
                        ),

                        const SizedBox(height: 16),

                        // Business option
                        _SignupOption(
                          label: "Business",
                          description: "Raising capital for your company",
                          icon: Icons.business_outlined,
                          onTap: () => context.go("/signup/business"),
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
    );
  }
}

// ─── Signup Option Card ──────────────────────────────────────────────────────

class _SignupOption extends StatefulWidget {
  const _SignupOption({
    required this.label,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_SignupOption> createState() => _SignupOptionState();
}

class _SignupOptionState extends State<_SignupOption> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withOpacity(0.12)
                : Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF4A90D9).withOpacity(0.4)
                  : Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90D9).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFF4A90D9),
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.6),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: _isHovered
                    ? const Color(0xFF4A90D9)
                    : Colors.white.withOpacity(0.3),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Glow Circle ─────────────────────────────────────────────────────────────

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
