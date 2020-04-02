import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/topbar.dart';
import 'package:sg_rocket/lower_top_bar.dart';
import 'package:sg_rocket/route_tile_list.dart';

import 'models/database.dart';
import 'models/routeQuery.dart';

class LonelyRoute extends StatefulWidget {
  final int buttonpressed;

  const LonelyRoute({Key key, this.buttonpressed}) : super(key: key);

  @override
  _LonelyRouteState createState() => _LonelyRouteState(buttonpressed: buttonpressed);
}

class _LonelyRouteState extends State<LonelyRoute> {
  final int buttonpressed;
  _LonelyRouteState({this.buttonpressed});
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
