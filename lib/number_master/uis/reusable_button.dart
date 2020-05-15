import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  @required
  final Widget destinationWidget;
  final String text;
  final int pageNumber;

  CustomButton({this.destinationWidget, this.text = "Done", this.pageNumber});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        width: width * 0.5,
        child: RaisedButton(
          color: Colors.blue,
          colorBrightness: Brightness.light,
          onPressed: () {
            print("new page number ${this.pageNumber}");
            Navigator.pushReplacement(context, _createRoute((this.pageNumber)));
          },
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Route _createRoute(int args) {
    return PageRouteBuilder(
      settings: RouteSettings(arguments: args),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) =>
          destinationWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation =
            CurvedAnimation(parent: animation, curve: Curves.decelerate);
        return ScaleTransition(
          alignment: Alignment.center,
          scale: animation,
          child: child,
        );
      },
    );
  }
}
