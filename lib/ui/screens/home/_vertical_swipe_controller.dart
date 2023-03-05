// import 'package:wondrous_app_clone/common_libs.dart';
part of 'wonders_home_screen.dart';

class _VerticalSwipeController {
  _VerticalSwipeController(this.ticker, this.onSwipeComplete);

  final TickerProvider ticker;
  final VoidCallback onSwipeComplete;
  final swipeAmt = ValueNotifier<double>(0);
  final isPointerDown = ValueNotifier<bool>(false);
  final double _pullToViewDetailsThreshold = 150;

  late final swipeReleaseAnim = AnimationController(vsync: ticker)
    ..addListener(handleSwipeReleaseAnimTick);

  void handleSwipeReleaseAnimTick() => swipeAmt.value = swipeReleaseAnim.value;
  void handleTapDown() => isPointerDown.value = true;
  void handleTapCancelled() => isPointerDown.value = false;

  void handleVerticalSwipeCancelled() {
    // %ODO:
    swipeReleaseAnim.reverse(from: swipeAmt.value);
    isPointerDown.value = false;
  }

  void handleVerticalSwipeUpdate(DragUpdateDetails details) {
    if (swipeReleaseAnim.isAnimating) swipeReleaseAnim.stop();
    isPointerDown.value = true;
    double value =
        (swipeAmt.value - details.delta.dy / _pullToViewDetailsThreshold)
            .clamp(0, 1);
    if (value != swipeAmt.value) {
      swipeAmt.value = value;
      if (swipeAmt.value == 1) {
        onSwipeComplete();
      }
    }
  }

  Widget wrapGestureDetector(Widget child, {Key? key}) => GestureDetector(
        key: key,
        excludeFromSemantics: true,
        onTapDown: (_) => handleTapDown(),
        onTapUp: (_) => handleTapCancelled(),
      );
}
