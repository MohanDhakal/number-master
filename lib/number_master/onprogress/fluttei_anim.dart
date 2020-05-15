import 'package:flutter/material.dart';


class GifDemo extends StatelessWidget {
  static const String routeName = "/gifdemo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Image.asset(
            "images/clap.gif",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
