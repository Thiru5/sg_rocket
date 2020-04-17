import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sg_rocket/models/mrt_list.dart';


class FareCalculator extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<FareCalculator> {
  List data;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          child: new Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: new FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/MrtLrtFare.json'),
                builder: (context, snapshot) {
                  List<Mrt> mrtStops =
                  parseJson(snapshot.data.toString());
                  return mrtStops.isNotEmpty
                      ? new MrtList(mrtList: mrtStops,)
                      : new Center(child: new CircularProgressIndicator());
                }),
          ),
        ));
  }

  List<Mrt> parseJson(String response) {
    if(response==null){
      return [];
    }
    final parsed =
    json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Mrt>((json) => new Mrt.fromJson(json)).toList();
  }

  calculate(double distance){
    double fare = 92.0 + distance + 3.2*10.0;
    if(fare<92){fare = 0.92;}else if(fare>=217){fare = 2.17;}{}
    return fare;
  }
  calcualteGojek(double distance){
    double fare = 4.10+ distance/1000*0.675;
    return fare;
  }
  calculateGrab(double distance, double duration){
    double fare = 2.5+(distance/1000*0.5)+(duration/60*0.16);
    if(fare<6.00){fare = 6.00;}
    return fare;
  }
}


class Mrt {
  final String code;
  final String description;
  final String roadName;
  final int farePrice;

  Mrt({this.code, this.description, this.roadName, this.farePrice});

  factory Mrt.fromJson(Map<String, dynamic> json) {
    return new Mrt(
      code: json['BusStopCode'] as String,
      description: json['Description'] as String,
      roadName: json['RoadName'] as String,
      farePrice: json['fare_per_ride']
    );
  }
}

