import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    List endPoint;
    List startPoint;
    LatLng destination;

    final locationQuery = Provider.of<List<RouteQuery>>(context);
    locationQuery.forEach((locationQuery) {
      endAdd = locationQuery.endAddress;
      endPoint = locationQuery.endPoint;
      startAdd = locationQuery.startAddress;
      startPoint = locationQuery.startPoint;
      destination = LatLng(endPoint[0], endPoint[1]);
    });



    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
            child: new InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapsRoute(
              destination: destination,
              destName: endAdd,
              startName: startAdd,
            )));
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
