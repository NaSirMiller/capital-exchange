class LandingConfig {
  // Breakpoints
  static const double desktopBreakpoint = 1024;
  static const double tabletBreakpoint = 768;

  // Background images
  static const List<String> backgroundImages = [
    "assets/images/capital_region_1.jpg",
    "assets/images/capital_region_2.jpg",
    "assets/images/capital_region_3.jpg",
    "assets/images/capital_region_4.jpg",
  ];

  // Story duration
  static const Duration storyDuration = Duration(seconds: 4);

  // Animation durations
  static const Duration logoAnimationDuration = Duration(milliseconds: 1000);
  static const Duration titleAnimationDuration = Duration(milliseconds: 1000);
  static const Duration taglineAnimationDuration = Duration(milliseconds: 1200);
  static const Duration buttonsAnimationDuration = Duration(milliseconds: 1400);
  static const Duration pillsAnimationDuration = Duration(milliseconds: 1600);

  // Colors
  static const int primaryBlue = 0xFF4A90D9;
  static const int primaryBlueLight = 0xFF5BA3E8;
  static const int navyDark = 0xFF0A1628;
  static const int navyMid = 0xFF1A2E4A;
  static const int navyLight = 0xFF0D3B66;
  static const int logoGradientStart = 0xFF1A3A5C;
  static const int logoGradientEnd = 0xFF0D2137;

  // Spacing
  static const double desktopHorizontalPadding = 80;
  static const double tabletHorizontalPadding = 60;
  static const double mobileHorizontalPadding = 24;

  // Sizing
  static const double desktopLogoSize = 100;
  static const double mobileLogoSize = 80;
  static const double desktopButtonWidth = 340;
  static const double tabletButtonWidth = 300;
  static const double mobileButtonWidth = 280;
  static const double buttonHeight = 58;

  // Text
  static const String appTitle = "Capital Exchange";
  static const String tagline = "Invest in your community.\nGrow together.";
  static const String bottomLabel = "Capital Region • Community Driven";

  // Feature pills
  static const List<FeaturePillData> features = [
    FeaturePillData(icon: "business_outlined", text: "Support Local"),
    FeaturePillData(icon: "trending_up_outlined", text: "Earn Returns"),
    FeaturePillData(icon: "people_outline", text: "Community Driven"),
  ];
}

class FeaturePillData {
  final String icon;
  final String text;

  const FeaturePillData({required this.icon, required this.text});
}
