import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/topbar.dart';
import 'package:sg_rocket/lower_top_bar.dart';
import 'package:sg_rocket/route_tile_list.dart';

import 'models/database.dart';
import 'models/routeQuery.dart';

class FastestRoute extends StatefulWidget {
  final int buttonpressed;

  const FastestRoute({Key key, this.buttonpressed}) : super(key: key);
  @override
  _FastestRouteState createState() => _FastestRouteState(buttonpressed: buttonpressed);
}

class _FastestRouteState extends State<FastestRoute> {
  final int buttonpressed;
  _FastestRouteState({this.buttonpressed});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RouteQuery>>.value(
        value: LocationQuery().routeQuery,
        child: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TopBar(),
                    LowerTopBar(buttonpressed: buttonpressed),
                    Expanded(
                        child: Container(
                      width: 400,
                      height: 100,
                      child: RouteTileList(),
                    ))
                  ],
                ),

              ],
            ),
          ),
        ));
  }
}
