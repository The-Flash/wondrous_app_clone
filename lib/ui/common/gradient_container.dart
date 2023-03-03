import 'package:wondrous_app_clone/common_libs.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.colors,
    required this.stops,
    this.width,
    this.height,
    this.child,
    this.begin,
    this.end,
    this.alignment,
    this.blendMode,
    this.borderRadius,
  });

  final List<Color> colors;
  final List<double> stops;
  final double? width;
  final double? height;
  final Widget? child;
  final Alignment? begin;
  final Alignment? end;
  final Alignment? alignment;
  final BlendMode? blendMode;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: width,
        height: height,
        alignment: alignment,
        decoration: BoxDecoration(
          backgroundBlendMode: blendMode,
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: begin ?? Alignment.centerLeft,
            end: end ?? Alignment.centerRight,
            colors: colors,
            stops: stops,
          ),
        ),
      ),
    );
  }
}
