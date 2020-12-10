import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:mathniac_plus/tasks/custom_route.dart';

Widget _home;
Function _customFunction;
String _imagePath;
int _duration;
MySplashType _runfor;
Color _backGroundColor;
String _animationEffect;
double _logoSize;

enum MySplashType { StaticDuration, BackgroundProcess }

Map<dynamic, Widget> _outputAndHome = {};

class MySplash extends StatefulWidget {
  MySplash(
      {@required String imagePath,
      @required Widget home,
      Function customFunction,
      int duration,
      MySplashType type,
      Color backGroundColor = Colors.white,
      String animationEffect = 'fade-in',
      double logoSize = 250.0,
      Map<dynamic, Widget> outputAndHome}) {
    assert(duration != null);
    assert(home != null);
    assert(imagePath != null);

    _home = home;
    _duration = duration;
    _customFunction = customFunction;
    _imagePath = imagePath;
    _runfor = type;
    _outputAndHome = outputAndHome;
    _backGroundColor = backGroundColor;
    _animationEffect = animationEffect;
    _logoSize = 250.0;
  }

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.reset();
    super.dispose();
  }

  navigator(home) {
    Navigator.of(context)
        .pushReplacement(CustomRoute(builder: (context) => home));
  }

  Widget _buildAnimation() {
    switch (_animationEffect) {
      case 'fade-in':
        {
          return FadeTransition(
            opacity: _animation,
            child: Center(
              child:
                  SizedBox(height: _logoSize, child: Image.asset(_imagePath)),
            ),
          );
        }
      case 'zoom-in':
        {
          return ScaleTransition(
            scale: _animation,
            child: Center(
              child:
                  SizedBox(height: _logoSize, child: Image.asset(_imagePath)),
            ),
          );
        }
      case 'zoom-out':
        {
          return ScaleTransition(
            scale: Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
                parent: _animationController, curve: Curves.linear)),
            child: Center(
              child:
                  SizedBox(height: _logoSize, child: Image.asset(_imagePath)),
            ),
          );
        }
      case 'top-down':
        {
          return SizeTransition(
            sizeFactor: _animation,
            child: Center(
              child:
                  SizedBox(height: _logoSize, child: Image.asset(_imagePath)),
            ),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    _runfor == MySplashType.BackgroundProcess
        ? Future.delayed(Duration.zero).then((value) {
            var res = _customFunction();
            //print("$res+${_outputAndHome[res]}");
            Future.delayed(Duration(milliseconds: _duration)).then((value) {
              Navigator.of(context).pushReplacement(
                  CustomRoute(builder: (context) => _outputAndHome[res]));
            });
          })
        : Future.delayed(Duration(milliseconds: _duration)).then((value) {
            Navigator.of(context)
                .pushReplacement(CustomRoute(builder: (context) => _home));
          });

    return Scaffold(backgroundColor: _backGroundColor, body: _buildAnimation());
  }
}
