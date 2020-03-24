import 'package:flutter/material.dart';

class LowerTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.amber,
      child: Column(
        children: <Widget>[
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
        ],
      ),
    );
  }
}
