import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:sg_rocket/googleMap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../calculate.dart';
import '../models/routeQuery.dart';

class Route {
  final List<dynamic> route;
  Route(this.route);
}

Route _parseJsonForRoute(String jsonString) {
  Map decoded = jsonDecode(jsonString);
  List<dynamic> routes = decoded['routes'];
  return new Route(routes);
}

class RouteDetails {
  final String distanceText;
  final int distanceNum;
  final String durationText;
  final int durationNum;
  final String instruction;
  final String travelMode;
  RouteDetails(this.distanceText, this.distanceNum, this.durationText,
      this.durationNum, this.instruction, this.travelMode);
}

class Routes {
  List<RouteDetails> routes;
  final double totalCost;
  final String dist;
  Routes(this.routes, this.totalCost, this.dist);
}



class RouteTileList extends StatefulWidget {
  @override
  _RouteTileListState createState() => _RouteTileListState();
}

class _RouteTileListState extends State<RouteTileList> {
  Future<String> _loadJson() async {
    return await rootBundle.loadString('assets/map_nav.json');
  }
  void initState(){
    getTransportValues();
    print(allRoutes1.length);
    super.initState();
  }

  List<Routes> allRoutes1 = new List<Routes>();

  Future getTransportValues() async {
    String jsonCrossword = await _loadJson();
    Route displayRoute = _parseJsonForRoute(jsonCrossword);
    List<Routes> allRoutes = new List<Routes>();
    int x = displayRoute.route.length; //3
    for (int a = 0; a < x; a++) {
      List<RouteDetails> routeDetails = new List<RouteDetails>();
      String aa = displayRoute.route[a]["legs"][0]["duration"]["text"];
      int y = displayRoute.route[a]["legs"][0]["steps"].length; //3
      double cost = 0;
      for (int z = 0; z < y; z++) {
        String distanceText =
            displayRoute.route[a]["legs"][0]["steps"][z]["distance"]["text"];
        int distanceNum =
            displayRoute.route[a]["legs"][0]["steps"][z]["distance"]["value"];
        String durationText =
            displayRoute.route[a]["legs"][0]["steps"][z]["duration"]["text"];
        int durationNum =
            displayRoute.route[a]["legs"][0]["steps"][z]["duration"]["value"];
        String instruction =
            displayRoute.route[a]["legs"][0]["steps"][z]["html_instructions"];
        String travelMode =
            displayRoute.route[a]["legs"][0]["steps"][z]["travel_mode"];
        if (travelMode == "TRANSIT") {
          cost += Calculation().calculate(distanceNum.toDouble());
        }
        routeDetails.add(new RouteDetails(distanceText, distanceNum,
            durationText, durationNum, instruction, travelMode));
            print('test');
      }

      setState(() {
        allRoutes1.add(new Routes(routeDetails, cost,aa));
        print('test');
      });
    
    }
  }

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
      itemCount: allRoutes1.length,
      itemBuilder: (context, index) {
        return Card(
            child: new InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapsRoute(
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
                  padding: EdgeInsets.fromLTRB(50.0, 0.0, 30.0, 0.0),
                  child: Text(
                    '\$' + allRoutes1[index].totalCost.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Text(
                    '${allRoutes1[index].dist}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
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