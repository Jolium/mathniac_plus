import 'package:flutter/material.dart';

import 'custom_route.dart';

enum MySplashType { staticDuration, backgroundProcess }

class MySplash extends StatefulWidget {
  final int duration;
  final String animationEffect;
  final double logoSize;
  final String imagePath;
  final Color backGroundColor;
  final Widget home;
  final MySplashType? type;

  const MySplash({
    required this.imagePath,
    required this.home,
    this.type = MySplashType.backgroundProcess,
    this.duration = 1600,
    this.backGroundColor = Colors.black,
    this.animationEffect = 'zoom-out',
    this.logoSize = 250.0,
  });

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late int _duration;

  @override
  void initState() {
    super.initState();
    if (widget.duration < 1000) {
      _duration = 2000;
    } else {
      _duration = widget.duration;
    }
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInCirc,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.reset();
    super.dispose();
  }

  void navigator(Widget home) {
    Navigator.of(context)
        .pushReplacement(CustomRoute(builder: (context) => home));
  }

  Widget _buildAnimation() {
    switch (widget.animationEffect) {
      case 'fade-in':
        {
          return FadeTransition(
            opacity: _animation,
            child: Center(
              child: SizedBox(
                height: widget.logoSize,
                child: Image.asset(widget.imagePath),
              ),
            ),
          );
        }
      case 'zoom-in':
        {
          return ScaleTransition(
            scale: _animation,
            child: Center(
              child: SizedBox(
                height: widget.logoSize,
                child: Image.asset(widget.imagePath),
              ),
            ),
          );
        }
      case 'zoom-out':
        {
          return ScaleTransition(
            scale: Tween(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.linear,
              ),
            ),
            child: Center(
              child: SizedBox(
                height: widget.logoSize,
                child: Image.asset(widget.imagePath),
              ),
            ),
          );
        }
      // case 'top-down':
      default:
        {
          return SizeTransition(
            sizeFactor: _animation,
            child: Center(
              child: SizedBox(
                height: widget.logoSize,
                child: Image.asset(widget.imagePath),
              ),
            ),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.type == MySplashType.backgroundProcess
        ? Future.delayed(Duration.zero).then((value) {
            Future.delayed(Duration(milliseconds: _duration)).then((value) {
              Navigator.of(context).pushReplacement(
                  CustomRoute(builder: (context) => widget.home));
            });
          })
        : Future.delayed(Duration(milliseconds: _duration)).then((value) {
            Navigator.of(context).pushReplacement(
                CustomRoute(builder: (context) => widget.home));
          });

    return Scaffold(
      backgroundColor: widget.backGroundColor,
      body: _buildAnimation(),
    );
  }
}
