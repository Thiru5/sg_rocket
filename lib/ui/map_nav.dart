import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/ui/topbar.dart';
import 'package:sg_rocket/ui/lower_top_bar.dart';
import 'package:sg_rocket/ui/route_tile_list.dart';

import '../models/database.dart';
import '../models/routeQuery.dart';

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
                Column(
                  children: <Widget>[
                    TopBar(),
                    LowerTopBar(buttonpressed: buttonpressed),
                    Expanded(
                      child: Container(
                        width: 400,
                        height:100,
                        child: RouteTileList(),
                      )
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
