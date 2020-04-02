import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/topbar.dart';
import 'package:sg_rocket/lower_top_bar.dart';

import 'models/database.dart';
import 'models/routeQuery.dart';

class MapNavMenu extends StatefulWidget {
  final int buttonpressed;
  MapNavMenu({this.buttonpressed});
  @override
  _MapNavMenuState createState() => _MapNavMenuState(buttonpressed: buttonpressed);
}

class _MapNavMenuState extends State<MapNavMenu> {
  final int buttonpressed;
  _MapNavMenuState({this.buttonpressed});
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RouteQuery>>.value(
        value: LocationQuery().routeQuery,
        child: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                Image.asset("assets/load_up.png"),
                Column(
                  children: <Widget>[
                    TopBar(),
                    LowerTopBar(buttonpressed: buttonpressed),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    height: 120.0,
                    width: 120.0,
                      child: FloatingActionButton(
                        child: Text("Confirm",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9.0,
                            )),
                        backgroundColor: Colors.amber[300],
                        onPressed: () {
                        },
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ));
  }
}
