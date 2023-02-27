import 'package:wondrous_app_clone/common_libs.dart';

part './_vertical_swipe_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
