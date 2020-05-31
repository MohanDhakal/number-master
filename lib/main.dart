import 'dart:math' as math;

import 'package:animation_practice/level1/uis/select_num_screen.dart';
import 'package:animation_practice/level1/uis/welcome_screen.dart';
import 'package:animation_practice/number_master/onprogress/question_screen.dart';
import 'package:animation_practice/number_master/uis/page1.dart';
import 'package:animation_practice/number_master/uis/page2.dart';
import 'package:animation_practice/number_master/uis/page3.dart';
import 'package:animation_practice/number_master/uis/page4.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  return runApp(MaterialApp(
    initialRoute: Home.routeName,
    routes: {
      QuestionScreen.routeName: (context) => QuestionScreen(),
      Home.routeName: (context) => Home(),
      Page1.routeName: (context) => Page1(),
      Page2.routeName: (context) => Page2(),
      Page3.routeName: (context) => Page3(),
      Page4.routeName: (context) => Page4()
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.purpleAccent,
    ),
  ));
}

class Home extends StatelessWidget {
  static const String routeName = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarColor: Colors.purpleAccent),
          child: WelcomeScreen()),
    );
  }
}

//this is an app screen
class SampleApp extends StatefulWidget {
  @override
  _SampleAppState createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp> with TickerProviderStateMixin {
  String sampleText;
  Animation<double> animation;
  AnimationController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    fixDelay().then((value) {
      setState(() {
        sampleText = value;
        print(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Future<String> fixDelay() async {
    await Future.delayed(Duration(seconds: 2), () {
      return "this is my text";
    });
    return "this is my text";
  }

  getBody() {
    if (sampleText == null) {
      controller = AnimationController(
          duration: const Duration(milliseconds: 2000), vsync: this);

      animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
        ..addStatusListener((status) {
          if (sampleText != null) {
            controller.dispose();
          } else if (status == AnimationStatus.completed) {
            controller.reverse();
          } else if (status == AnimationStatus.reverse) {
            controller.forward();
          }
        })
        ..addStatusListener((state) => print("$state"));
      controller.forward();

      return AnimatedLogo(
        animation: animation,
      );
    } else {
      return Container(
        child: Center(
          child: Text('$sampleText'),
        ),
      );
    }
  }
}

//reusable animation

class AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.7, end: 0.1);
  static final _translateTween = Tween<double>(begin: 0, end: -50);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Center(
        child: Transform.translate(
          offset: Offset(0, _translateTween.evaluate(animation)),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            width: 50,
            child: Transform.rotate(
              child: Image.asset("images/logo.png"),
              angle: math.pi,
            ),
          ),
        ),
      ),
    );
  }
}
