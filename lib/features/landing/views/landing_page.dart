import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:capital_commons/features/landing/widgets/auth_buttons.dart";
import "package:capital_commons/features/landing/widgets/background_carousel.dart";
import "package:capital_commons/features/landing/widgets/bottom_label.dart";
import "package:capital_commons/features/landing/widgets/feature_pills.dart";
import "package:capital_commons/features/landing/widgets/landing_hero_content.dart";
import "package:capital_commons/features/landing/widgets/story_progress_widget.dart";

class LandingPage extends HookWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isMobile = screenWidth < 768;

    // Background images for the carousel
    final backgroundImages = [
      "assets/images/capital_region_1.jpg",
      "assets/images/capital_region_2.jpg",
      "assets/images/capital_region_3.jpg",
      "assets/images/capital_region_4.jpg",
    ];

    final currentImageIndex = useState(0);
    final pageController = usePageController();

    // Handle image transitions
    void handleIndexChange(int index) {
      currentImageIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background carousel with images
            BackgroundCarousel(
              controller: pageController,
              images: backgroundImages,
              onPageChanged: (index) => currentImageIndex.value = index,
            ),

            // Story progress bars at top
            StoryProgressWidget(
              imageCount: backgroundImages.length,
              currentIndex: currentImageIndex.value,
              onIndexChanged: handleIndexChange,
            ),

            // Main content
            Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 1400 : double.infinity,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 80 : (isTablet ? 60 : 24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    // Hero content (logo, title, tagline)
                    LandingHeroContent(
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                      isMobile: isMobile,
                    ),

                    SizedBox(height: isDesktop ? 56 : 40),

                    // Auth buttons (Sign Up & Login)
                    AuthButtons(
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                      isMobile: isMobile,
                    ),

                    SizedBox(height: isDesktop ? 40 : 30),

                    // Feature pills (desktop/tablet only)
                    if (isDesktop || isTablet) const FeaturePills(),
                  ],
                ),
              ),
            ),

            // Bottom label
            const BottomLabel(),
          ],
        ),
      ),
    );
  }
}
