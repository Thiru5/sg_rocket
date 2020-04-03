import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:sg_rocket/maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/routeQuery.dart';

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

class Calculation {
  double calculate(double distance) {
    double fare = 92.0 + distance + 3.2 * 10.0;
    if (fare < 92) {
      fare = 0.92;
    } else if (fare >= 217) {
      fare = 2.17;
    }
    {}
    return fare;
  }

  double calcualteGojek(double distance) {
    double fare = 4.10 + distance / 1000 * 0.675;
    return fare;
  }

  double calculateGrab(double distance, double duration) {
    double fare = 2.5 + (distance / 1000 * 0.5) + (duration / 60 * 0.16);
    if (fare < 6.00) {
      fare = 6.00;
    }
    return fare;
  }
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
    extractJson();
    print(allRoutes1.length);
    super.initState();
  }

  List<Routes> allRoutes1 = new List<Routes>();

  Future extractJson() async {
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
        allRoutes.add(new Routes(routeDetails, cost,aa));
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
                  padding: EdgeInsets.fromLTRB(60.0, 0.0, 30.0, 0.0),
                  child: Text(
                    '\$' + allRoutes1[index].totalCost.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
                  child: Text(
                    '${allRoutes1[index].dist}',
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