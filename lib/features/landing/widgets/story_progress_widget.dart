import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "dart:async";

class StoryProgressWidget extends HookWidget {
  const StoryProgressWidget({
    super.key,
    required this.imageCount,
    required this.currentIndex,
    required this.onIndexChanged,
    this.duration = const Duration(seconds: 4),
  });

  final int imageCount;
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.0);
    final isPaused = useState(false);
    final screenWidth = MediaQuery.of(context).size.width;
    final responsivePadding = _getResponsivePadding(screenWidth);

    useEffect(() {
      Timer? progressTimer;
      final progressInterval = 16; // ~60fps
      final incrementAmount = 1000 / duration.inMilliseconds;

      void startProgress() {
        progress.value = 0.0;

        progressTimer = Timer.periodic(
          Duration(milliseconds: progressInterval),
          (timer) {
            if (!isPaused.value && progress.value < 1.0) {
              progress.value =
                  (progress.value + incrementAmount / (1000 / progressInterval))
                      .clamp(0.0, 1.0);
            }

            if (progress.value >= 1.0) {
              timer.cancel();
              Future.delayed(const Duration(milliseconds: 100), () {
                final nextIndex = (currentIndex + 1) % imageCount;
                onIndexChanged(nextIndex);
              });
            }
          },
        );
      }

      startProgress();

      return () {
        progressTimer?.cancel();
      };
    }, [currentIndex]);

    return Positioned(
      top: 24,
      left: responsivePadding,
      right: responsivePadding,
      child: MouseRegion(
        onEnter: (_) => isPaused.value = true,
        onExit: (_) => isPaused.value = false,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black.withOpacity(0.25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: List.generate(
              imageCount,
              (index) => Expanded(
                child: _ProgressBar(
                  index: index,
                  currentIndex: currentIndex,
                  progress: progress.value,
                  onTap: () => onIndexChanged(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getResponsivePadding(double screenWidth) {
    if (screenWidth >= 1024) return 80;
    if (screenWidth >= 768) return 60;
    return 24;
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.index,
    required this.currentIndex,
    required this.progress,
    required this.onTap,
  });

  final int index;
  final int currentIndex;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isCompleted = index < currentIndex;
    final isActive = index == currentIndex;
    final fillAmount = isCompleted ? 1.0 : (isActive ? progress : 0.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white.withOpacity(0.3),
        ),
        child: AnimatedFractionallySizedBox(
          duration: const Duration(milliseconds: 16),
          curve: Curves.linear,
          alignment: Alignment.centerLeft,
          widthFactor: fillAmount,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [Color(0xFF4A90D9), Color(0xFF5BA3E8)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4A90D9).withOpacity(0.6),
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
