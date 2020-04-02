import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AllRoute {
  List<Route> route;
  AllRoute([this.route]);
  factory AllRoute.fromJson(dynamic json) {
    if (json['routes'] != null) {
      var allrouteObjsJson = json['route'] as List;
      List<Route> _route = allrouteObjsJson
          .map((allrouteJson) => Route.fromJson(allrouteJson))
          .toList();
      return AllRoute(_route);
    }
  }
}

class Route {
  List<Steps> step;
  Route([this.step]);
  factory Route.fromJson(dynamic json) {
    if (json['legs'] != null) {
      var routeObjsJson = json['legs'] as List;
      List<Steps> _steps =
          routeObjsJson.map((routeJson) => Steps.fromJson(routeJson)).toList();
      return Route(_steps);
    }
  }
}

class Steps {
  List<IndivStep> indivStep;
  Steps([this.indivStep]);
  factory Steps.fromJson(dynamic json) {
    if (json['steps'] != null) {
      var indivStepsObjsJson = json['steps'] as List;
      List<IndivStep> _indivSteps = indivStepsObjsJson
          .map((stepJson) => IndivStep.fromJson(stepJson))
          .toList();
      return Steps(_indivSteps);
    }
  }
}

class IndivStep {
  Distance distance;
  Duration duration;
  String instructions;
  String travelMode;
  IndivStep({this.distance, this.duration, this.instructions, this.travelMode});
  factory IndivStep.fromJson(Map<String, dynamic> parsedJson) {
    return IndivStep(
      distance: Distance.fromJson(parsedJson['distance']),
      duration: Duration.fromJson(parsedJson['duration']),
      instructions: parsedJson['html_instructions'],
      travelMode: parsedJson['travel_mode'],
    );
  }
}

class Distance {
  String distanceText;
  Distance({this.distanceText});

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(distanceText: json['text']);
  }
}

class Duration {
  String durationText;
  Duration({this.durationText});
  factory Duration.fromJson(Map<String, dynamic> json) {
    return Duration(durationText: json['text']);
  }
}

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
  List<IndivStep> list = (json.decode('map_nav.json') as List)
      .map((data) => new IndivStep.fromJson(data))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: new Text(list[index].distance.toString()));
                })));
  }
}

/*Future<String> _loadStepsAsset() async {
  return await rootBundle.loadString('assets/map_nav.json');
}

Future<IndivStep> loadSteps() async {
  String jsonString = await _loadStepsAsset();
  final jsonResponse = json.decode(jsonString);
  return new IndivStep.fromJson(jsonResponse);
}

class RouteDisplay extends StatefulWidget {
  final IndivStep indivStep;
  RouteDisplay({this.indivStep});
  @override
  RouteDisplayState createState() => RouteDisplayState();
}

class RouteDisplayState extends State<RouteDisplay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Load Json'),
          ),
          body: new Container(
              padding: new EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  Text(
                      "Hi ${widget.indivStep.distance}")
                ],
              ))),
    );
  }
}*/
