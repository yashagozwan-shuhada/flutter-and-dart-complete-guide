import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/src/widgets/cat_widget.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with TickerProviderStateMixin<AnimationScreen> {
  late final Animation<double> _catAnimation;
  late final AnimationController _catController;

  late final Animation<double> _boxAnimation;
  late final AnimationController _boxController;

  @override
  void initState() {
    _boxController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _boxAnimation = Tween<double>(
      begin: pi * 0.6,
      end: pi * 0.65,
    ).animate(
      CurvedAnimation(
        parent: _boxController,
        curve: Curves.easeInOut,
      ),
    );

    _boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _boxController.reverse();
      }

      if (status == AnimationStatus.dismissed) {
        _boxController.forward();
      }
    });

    _boxController.forward();

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
      _boxController.forward();
      _catController.reverse();
    } else if (_catController.status == AnimationStatus.dismissed) {
      _boxController.stop();
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
              buildRightFlap(),
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
    return Positioned(
      left: 3,
      child: AnimatedBuilder(
        animation: _boxController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _boxAnimation.value,
            alignment: Alignment.topLeft,
            child: child,
          );
        },
        child: Container(
          height: 10,
          width: 125,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3,
      child: AnimatedBuilder(
        animation: _boxController,
        builder: (context, child) {
          return Transform.rotate(
            angle: -_boxAnimation.value,
            alignment: Alignment.topRight,
            child: child,
          );
        },
        child: Container(
          height: 10,
          width: 125,
          color: Colors.red,
        ),
      ),
    );
  }
}
