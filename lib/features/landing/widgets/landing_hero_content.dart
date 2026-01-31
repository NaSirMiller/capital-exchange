import "package:flutter/material.dart";

class LandingHeroContent extends StatelessWidget {
  const LandingHeroContent({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.isMobile,
  });

  final bool isDesktop;
  final bool isTablet;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Logo mark with animation
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1000),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: _LogoMark(size: isDesktop ? 100 : 80),
        ),

        const SizedBox(height: 32),

        // Title with animation
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1000),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Text(
            "Capital Exchange",
            style: TextStyle(
              fontSize: isDesktop ? 72 : (isTablet ? 56 : 42),
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1.5,
              height: 1.1,
              shadows: const [
                Shadow(
                  blurRadius: 20,
                  color: Colors.black87,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),

        const SizedBox(height: 20),

        // Tagline with animation
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1200),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 700 : (isTablet ? 500 : 400),
            ),
            child: Text(
              "Invest in your community.\nGrow together.",
              style: TextStyle(
                fontSize: isDesktop ? 28 : (isTablet ? 24 : 20),
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 0.3,
                height: 1.5,
                shadows: const [
                  Shadow(
                    blurRadius: 12,
                    color: Colors.black87,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}

class _LogoMark extends StatelessWidget {
  const _LogoMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF4A90D9).withOpacity(0.5),
          width: 3,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [Color(0xFF1A3A5C), Color(0xFF0D2137)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90D9).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.trending_up_rounded,
          color: const Color(0xFF4A90D9),
          size: size * 0.48,
        ),
      ),
    );
  }
}
