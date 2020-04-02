import 'dart:convert';
import 'package:flutter/material.dart';

import 'bus_list.dart';
import 'bus_stops.dart';

class BusStops extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<BusStops> {
  List data;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          child: new Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: new FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/BusStops.json'),
                builder: (context, snapshot) {
                  List<BusStop> busStops =
                  parseJson(snapshot.data.toString());
                  return busStops.isNotEmpty
                      ? new BusList(busList: busStops,)
                      : new Center(child: new CircularProgressIndicator());
                }),
          ),
        ));
  }

  List<BusStop> parseJson(String response) {
    if(response==null){
      return [];
    }
    final parsed =
    json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<BusStop>((json) => new BusStop.fromJson(json)).toList();
  }
}
