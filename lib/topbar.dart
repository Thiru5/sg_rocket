import 'package:flutter/material.dart';
import 'package:sg_rocket/models/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sg_rocket/models/routeQuery.dart';

import 'main.dart';

class TopBar extends StatelessWidget {

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
                    '  From',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(width: 20),


                  Flexible(
                    child: Container(
                      child: Text(
                        startLocationName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
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

                  Flexible(
                    child: Container(
                      child: Text(
                        destinationName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
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
