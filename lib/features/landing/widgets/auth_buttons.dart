import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";

class AuthButtons extends HookWidget {
  const AuthButtons({
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
    final isHoveringSignup = useState(false);
    final isHoveringLogin = useState(false);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1400),
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
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
        children: [
          // Sign Up button
          _AuthButton(
            text: "Sign Up",
            onTap: () => context.go("/signup"),
            width: isDesktop ? 340 : (isTablet ? 300 : 280),
            height: 58,
            backgroundColor: const Color(0xFF4A90D9),
            textColor: Colors.white,
            borderColor: const Color(0xFF4A90D9),
            isHovered: isHoveringSignup,
            isPrimary: true,
          ),
          // Login button
          _AuthButton(
            text: "Login",
            onTap: () => context.go("/login"),
            width: isDesktop ? 340 : (isTablet ? 300 : 280),
            height: 58,
            backgroundColor: Colors.transparent,
            textColor: Colors.white,
            borderColor: Colors.white.withOpacity(0.4),
            isHovered: isHoveringLogin,
            isPrimary: false,
          ),
        ],
      ),
    );
  }
}

class _AuthButton extends HookWidget {
  const _AuthButton({
    required this.text,
    required this.onTap,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.isHovered,
    required this.isPrimary,
  });

  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final ValueNotifier<bool> isHovered;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: AnimatedBuilder(
        animation: isHovered,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: width,
            height: height,
            transform: Matrix4.translationValues(
              0.0,
              isHovered.value ? -4.0 : 0.0,
              0.0,
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: isHovered.value && !isPrimary
                      ? const Color(0xFF4A90D9)
                      : (isHovered.value && isPrimary
                            ? const Color(0xFF5BA3E8)
                            : backgroundColor),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: isHovered.value
                          ? const Color(0xFF4A90D9).withOpacity(0.5)
                          : Colors.black.withOpacity(0.4),
                      blurRadius: isHovered.value ? 24 : 16,
                      offset: Offset(0, isHovered.value ? 8 : 6),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: isHovered.value && !isPrimary
                        ? Colors.white
                        : textColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
