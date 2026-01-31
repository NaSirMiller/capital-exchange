import "package:flutter/material.dart";

class BackgroundCarousel extends StatelessWidget {
  const BackgroundCarousel({
    super.key,
    required this.controller,
    required this.images,
    required this.onPageChanged,
  });

  final PageController controller;
  final List<String> images;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        // PageView for sliding images
        PageView.builder(
          controller: controller,
          onPageChanged: onPageChanged,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.asset(
              images[index],
              fit: BoxFit.cover,
              width: screenSize.width,
              height: screenSize.height,
              errorBuilder: (context, error, stackTrace) {
                return _FallbackGradient();
              },
            );
          },
        ),

        // Gradient overlay for text readability
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.5),
                Colors.black.withValues(alpha: 0.75),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FallbackGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
    );
  }
}
