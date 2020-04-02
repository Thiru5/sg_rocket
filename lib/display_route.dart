import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

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
  RouteDetails(this.distanceText,this.distanceNum,this.durationText,this.durationNum,this.instruction,this.travelMode);
}

class Routes {
   List<RouteDetails> routes;
   final double totalCost;
   Routes(this.routes, this.totalCost);
}

class Calculation {
  double calculate(double distance){
    double fare = 92.0 + distance + 3.2*10.0;
    if(fare<92){fare = 0.92;}else if(fare>=217){fare = 2.17;}{}
    return fare;
  }
  double calcualteGojek(double distance){
    double fare = 4.10+ distance/1000*0.675;
    return fare;
  }
  double calculateGrab(double distance, double duration){
    double fare = 2.5+(distance/1000*0.5)+(duration/60*0.16);
    if(fare<6.00){fare = 6.00;}
    return fare;
  }
}

class ExtractData {
  Future<String> _loadJson() async {
    return await rootBundle.loadString('assets/map_nav.json');
  }

  Future extractJson() async {
    String jsonCrossword = await _loadJson();
    Route displayRoute = _parseJsonForRoute(jsonCrossword);
    List<Routes> allRoutes = new List<Routes>();
    int x = displayRoute.route.length; //3
    for(int a = 0; a<x; a++) {
      List<RouteDetails> routeDetails = new List<RouteDetails>();
      int y = displayRoute.route[a]["legs"][0]["steps"].length; //3
      double cost = 0;
      for (int z = 0; z<y ; z++) {
        String distanceText = displayRoute.route[a]["legs"][0]["steps"][z]["distance"]["text"];
        int distanceNum = displayRoute.route[a]["legs"][0]["steps"][z]["distance"]["value"];
        String durationText = displayRoute.route[a]["legs"][0]["steps"][z]["duration"]["text"];
        int durationNum = displayRoute.route[a]["legs"][0]["steps"][z]["duration"]["value"];
        String instruction = displayRoute.route[a]["legs"][0]["steps"][z]["html_instructions"];
        String travelMode = displayRoute.route[a]["legs"][0]["steps"][z]["travelMode"];
        if(travelMode=='TRANSIT') {
          cost += Calculation().calculate(distanceNum.toDouble());
        }
        routeDetails.add(new RouteDetails(distanceText, distanceNum, durationText, durationNum, instruction, travelMode));
      }
      allRoutes.add(new Routes(routeDetails,cost));
    }
    /*int routeLength = allRoutes.length;
    for(int xxx = 0; xxx<routeLength; xxx++) {
      int detailsLength = allRoutes[xxx].routes.length;
      for(int xxxx = 0; xxxx < detailsLength; xxxx++) {
         print(allRoutes[xxx].routes[xxxx].instruction);
         print(allRoutes[xxx].routes[xxxx].distanceText);
         print(allRoutes[xxx].routes[xxxx].durationText);
      }
      print(allRoutes[xxx].totalCost);
      print(".");
    }*/
    return allRoutes;
  }
}
