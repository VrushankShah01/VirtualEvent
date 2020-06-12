import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:evento/custom_route_transitions/slide_from_left.dart';
import 'package:evento/custom_route_transitions/slide_from_right.dart';
import 'package:evento/second_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

class FirstSplash extends StatefulWidget
{
  @override
  _FirstSplashState createState() => _FirstSplashState();
}

class _FirstSplashState extends State<FirstSplash> with SingleTickerProviderStateMixin
{
  AnimationController _controller;
  Animation<Offset> offsetAnimation;

  @override
  void initState()
  {
    super.initState();

    startTimer();

  }

  Tween<double> _scaleTween = Tween<double>(begin: 1, end: 2);

  @override
  void dispose()
  {
//    _controller.dispose();
    super.dispose();
  }

  startTimer() async
  {
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  route()
  {
    Navigator.pushReplacement(context, PageTransition(
      type: PageTransitionType.slideInLeft,
      child: SecondSplash(),
      duration: Duration(seconds: 2)
    ));
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SlideInRight(
          child: Image(
            image: AssetImage("assets/start.png"),
          ),
          duration: Duration(milliseconds: 600),
        ),
      )
    );
  }
}
