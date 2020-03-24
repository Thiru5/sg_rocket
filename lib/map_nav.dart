import 'package:flutter/material.dart';
import 'package:sg_rocket/topbar.dart';
import 'package:sg_rocket/lower_top_bar.dart';

class MapNavMenu extends StatefulWidget {
  @override
  _MapNavMenuState createState() => _MapNavMenuState();
}

class _MapNavMenuState extends State<MapNavMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Option Menu',
        home: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                Image.asset("assets/load_up.png"),
                Column(
                  children: <Widget>[
                    TopBar(),
                    LowerTopBar(),
                  ],
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 8 ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RawMaterialButton(
                          onPressed: () {},
                          child: const Text('Confirm',
                              style: TextStyle(fontSize: 20)),
                          fillColor: Colors.amber[300],
                          shape: CircleBorder(
                              side: BorderSide(
                                  width: 2,
                                  color: Colors.amber[300],
                                  style: BorderStyle.solid)),
                          padding: EdgeInsets.all(25),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ));
  }
}
