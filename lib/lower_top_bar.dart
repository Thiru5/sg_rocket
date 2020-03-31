import 'package:flutter/material.dart';

class LowerTopBar extends StatelessWidget {
  final int buttonpressed;
  LowerTopBar({this.buttonpressed});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.amber[50],
      child: Column(
        children: <Widget>[
          if (buttonpressed == 0)
            Align(
              alignment: Alignment.center,
              child: Text(
                'FASTEST ROUTE POSSIBLE',
                style: TextStyle(
                  fontSize: 27.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: "xx",
                ),
              ),
            ),
            if (buttonpressed == 1)
            Align(
              alignment: Alignment.center,
              child: Text(
                'CHEAPEST ROUTE AVAILABLE',
                style: TextStyle(
                  fontSize: 27.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: "xx",
                ),
              ),
            ),
            if (buttonpressed == 2)
            Align(
              alignment: Alignment.center,
              child: Text(
                'MODE OF TRANSPORT',
                style: TextStyle(
                  fontSize: 27.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: "xx",
                ),
              ),
            ),
            if (buttonpressed == 3)
            Align(
              alignment: Alignment.center,
              child: Text(
                'I HATE PEOPLE',
                style: TextStyle(
                  fontSize: 27.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: "xx",
                ),
              ),
            ),
        ],
      ),
    );
  }
}
