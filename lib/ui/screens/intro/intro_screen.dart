import 'package:flutter_svg/flutter_svg.dart';
import 'package:wondrous_app_clone/assets.dart';
import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/ui/common/static_text_scale.dart';
import 'package:wondrous_app_clone/ui/common/themed_text.dart';
import 'package:wondrous_app_clone/ui/common/utils/app_haptics.dart';
import 'package:wondrous_app_clone/ui/common/controls/app_page_indicator.dart';

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

  Widget _buildHzGradientOverlay({bool left = false}) {
    return Align(
      alignment: Alignment(left ? -1 : 1, 0),
      child: FractionallySizedBox(
        widthFactor: .5,
        child: Padding(
          padding: EdgeInsets.only(left: left ? 0 : 200, right: left ? 200 : 0),
          child: Transform.scale(
            scaleX: left ? -1 : 1,
            child: SizedBox.shrink(),
          ),
        ),
      ),
    );
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
                      controller: _pageController,
                      children: pages,
                      onPageChanged: (_) => AppHaptics.lightImpact(),
                    ),
                  ),
                ),
                IgnorePointer(
                  ignoringSemantics: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      Semantics(
                        header: true,
                        child: Container(
                          height: _logoHeight,
                          alignment: Alignment.center,
                          child: const _WondrousLogo(),
                        ),
                      ),
                      // masked image
                      SizedBox(
                        height: _imageSize,
                        width: _imageSize,
                        child: ValueListenableBuilder<int>(
                          valueListenable: _currentPage,
                          builder: (_, value, __) {
                            return AnimatedSwitcher(
                              duration: $styles.times.slow,
                              child: KeyedSubtree(
                                key: ValueKey(value),
                                child: _PageImage(data: pageData[value]),
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(_IntroScreenState._textHeight),
                      Container(
                        height: _pageIndicatorHeight,
                        alignment: const Alignment(0.0, 0),
                        child: AppPageIndicator(
                          controller: _pageController,
                          count: pageData.length,
                          color: $styles.colors.offWhite,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
                _buildHzGradientOverlay(left: true),
                _buildHzGradientOverlay(),
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

class _WondrousLogo extends StatelessWidget {
  const _WondrousLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExcludeSemantics(
          child: SvgPicture.asset(
            SvgPaths.compassSimple,
            color: $styles.colors.offWhite,
            height: 88,
          ),
        ),
        Gap($styles.insets.xs),
        StaticTextScale(
          child: Text(
            $strings.introSemanticWonderous,
            style: $styles.text.wonderTitle.copyWith(
              fontSize: 32 * $styles.scale,
              color: $styles.colors.offWhite,
            ),
          ),
        ),
      ],
    );
  }
}

class _PageImage extends StatelessWidget {
  const _PageImage({Key? key, required this.data}) : super(key: key);

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            '${ImagePaths.common}/intro-${data.img}.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
          ),
        ),
        Positioned.fill(
          child: Image.asset(
            '${ImagePaths.common}/intro-mask-${data.mask}.png',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
