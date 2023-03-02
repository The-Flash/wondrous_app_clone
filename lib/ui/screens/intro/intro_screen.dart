import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/ui/common/themed_text.dart';
import 'package:wondrous_app_clone/ui/common/utils/app_haptics.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static const double _imageSize = 250;
  static const double _logoHeight = 126;
  static const double _textHeight = 100;
  static const double _pageIndicatorHeight = 55;
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  static List<_PageData> pageData = [];

  late final PageController _pageController = PageController()
    ..addListener(_handlePageChanged);

  void _handlePageChanged() {
    int newPage = _pageController.page?.round() ?? 0;
    _currentPage.value = newPage;
  }

  void _handleSemanticSwipe(int dir) {
    _pageController.animateToPage((_pageController.page ?? 0).round() + dir,
        duration: $styles.times.fast, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pageData = [
      _PageData($strings.introTitleJourney, $strings.introDescriptionNavigate,
          'camel', '1'),
      _PageData($strings.introTitleExplore, $strings.introDescriptionUncover,
          'petra', '2'),
      _PageData($strings.introTitleDiscover, $strings.introDescriptionLearn,
          'statue', '3'),
    ];
    final List<Widget> pages = pageData.map((e) => _Page(data: e)).toList();

    return DefaultTextColor(
      color: $styles.colors.offWhite,
      child: Container(
        color: $styles.colors.black,
        child: SafeArea(
          child: Animate(
            delay: 500.ms,
            effects: const [FadeEffect()],
            child: Stack(
              children: [
                MergeSemantics(
                  child: Semantics(
                    onIncrease: () => _handleSemanticSwipe(1),
                    onDecrease: () => _handleSemanticSwipe(-1),
                    child: PageView(
                      children: pages,
                      onPageChanged: (_) => AppHaptics.lightImpact(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _PageData {
  const _PageData(this.title, this.desc, this.img, this.mask);

  final String title;
  final String desc;
  final String img;
  final String mask;
}

class _Page extends StatelessWidget {
  const _Page({super.key, required this.data});

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
      ),
    );
  }
}
