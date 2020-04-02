import 'package:flutter/material.dart';
import 'package:sg_rocket/models/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sg_rocket/models/routeQuery.dart';

import 'main.dart';

class TopBar extends StatelessWidget {
//  LatLng startLocation;
//  LatLng destination;
//  String startLocationName;
//  String destinationName;
//  TopBar({Key key, @required this.destination,this.startLocation,this.startLocationName,this.destinationName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String startAdd;
    String endAdd;

    final locationQuery = Provider.of<List<RouteQuery>>(context);
    locationQuery.forEach((locationQuery) {
      endAdd = locationQuery.endAddress;
      print(locationQuery.endPoint);
      startAdd = locationQuery.startAddress;
      print(locationQuery.startPoint);
    });
//    if(startLocationName == null)
//    {
//      startLocationName = 'Proceed Back to Select';
//    }
//
//    if(destinationName == null)
//    {
//      destinationName = 'Proceed Back to Select';
//    }

    return StreamProvider<List<RouteQuery>>.value(
      value: LocationQuery().routeQuery,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              Row(
                children: <Widget>[
                  Text(
                    'From',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    startAdd,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Text(
                    '  To  ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    endAdd,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
