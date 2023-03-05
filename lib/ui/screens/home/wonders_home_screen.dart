import 'package:go_router/go_router.dart';
import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/logic/data/wonder_data.dart';

part './_vertical_swipe_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  List<WonderData> get _wonders => wondersLogic.all;
  bool _isMenuOpen = false;

  late int _wonderIndex = 0;
  int get _numWonders => _wonders.length;

  /// Used to polish the transition when leaving this page for the details view.
  /// Used to capture the _swipeAmt at the time of transition, and freeze the wonder foreground in place as we transition away.
  double? _swipeOverride;

  /// Used to let the foreground fade in when this view is returned to (from details)
  bool _fadeInOnNextBuild = false;

  /// All of the items that should fade in when returning from details view.
  /// Using individual tweens is more efficient than tween the entire parent
  final _fadeAnims = <AnimationController>[];

  WonderData get currentWonder => _wonders[_wonderIndex];

  late final _VerticalSwipeController _swipeController =
      _VerticalSwipeController(this, _showDetailsPage);

  bool _isSelected(WonderType t) => t == currentWonder.type;

  void _showDetailsPage() async {
    _swipeOverride = _swipeController.swipeAmt.value;
    context.push(ScreenPaths.wonderDetails(currentWonder.type));
    await Future.delayed(100.ms);
    _swipeOverride = null;
    _fadeInOnNextBuild = true;
  }

  List<Widget> _buildBgAndClouds() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return _swipeController.wrapGestureDetector(
      Container(
        color: $styles.colors.black,
        child: Stack(
          children: [
            // background
            ..._buildBgAndClouds(),
            // wonders illustrations(main content)
            // foreground illustrations and gradients
            // controls that float on top of the various illustrations
          ],
        ).animate().fadeIn(),
      ),
    );
  }
}
