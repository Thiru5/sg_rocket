import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/ui/topbar.dart';
import 'package:sg_rocket/ui/lower_top_bar.dart';
import 'package:sg_rocket/ui/route_tile_list.dart';

import '../models/database.dart';
import '../models/routeQuery.dart';

class SortByCrowd extends StatefulWidget {
  final int buttonpressed;

  const SortByCrowd({Key key, this.buttonpressed}) : super(key: key);

  @override
  _SortByCrowdState createState() => _SortByCrowdState(buttonpressed: buttonpressed);
}

class _SortByCrowdState extends State<SortByCrowd> {
  final int buttonpressed;
  _SortByCrowdState({this.buttonpressed});
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
