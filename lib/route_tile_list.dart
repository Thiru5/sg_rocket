import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/maps.dart';

import 'models/routeQuery.dart';

class RouteTileList extends StatefulWidget {
  @override
  _RouteTileListState createState() => _RouteTileListState();
}

class _RouteTileListState extends State<RouteTileList> {
  @override
  Widget build(BuildContext context) {
    String startAdd;
    String endAdd;

    final locationQuery = Provider.of<List<RouteQuery>>(context);

    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
            child: new InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapsRoute()));
          },
          child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/drive_button.png'),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/elec_button.png'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60.0, 0.0, 30.0, 0.0),
                  child: Text(
                    '\$12',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
                  child: Text(
                    '25mins',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
