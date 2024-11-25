import 'package:flutter/material.dart';
import 'package:flutter_animation/src/widgets/cat_widget.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with TickerProviderStateMixin {
  late final Animation<double> _catAnimation;
  late final AnimationController _catController;

  @override
  void initState() {
    _catController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _catAnimation = Tween<double>(begin: -35, end: -80).animate(
      CurvedAnimation(
        parent: _catController,
        curve: Curves.easeIn,
      ),
    );

    _catController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _catController.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_catController.status == AnimationStatus.completed) {
      _catController.reverse();
    } else if (_catController.status == AnimationStatus.dismissed) {
      _catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: GestureDetector(
        onTap: _onTap,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: _catAnimation,
      builder: (context, child) {
        return Positioned(
          top: _catAnimation.value,
          left: 0,
          right: 0,
          child: child ?? const SizedBox.shrink(),
        );
      },
      child: const CatWidget(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.grey,
    );
  }

  Widget buildLeftFlap() {
    return Container(
      height: 10,
      width: 125,
      color: Colors.red,
    );
  }
}
