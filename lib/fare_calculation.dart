


import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Future<String> _loadStudent() async{

  return await rootBundle.loadString('asserts/MrtLrtFare.json');
}

Future loadStudent() async {
  var jsonString = await _loadStudent();
  final jsonResponse = json.decode(jsonString);
  print(jsonResponse['distance']);
  print(3); 
  Mrt student = new Mrt.fromJson(jsonResponse);
  print('test'); 
  print('distance: ${student.distance}');
  return Mrt.fromJson(jsonResponse);
  }


class Mrt {
  String fareType; 
  String applicableTime; 
  String distance; 
  int farePerRide; 

  Mrt ({
    this.fareType, 
    this.applicableTime, 
    this.distance, 
    this.farePerRide
  });
  
  factory Mrt.fromJson(Map<String, dynamic> json){
    return Mrt(
      applicableTime: json['applicable_time'],
      fareType: json['fare_type'],
      distance: json['distance'],
      farePerRide: json['fare_per_ride]']
    );
  }
}

class fareCalculate extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<fareCalculate > {
  Future<Mrt> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = loadStudent();
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Mrt>(
            future: futureAlbum,
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.hasData) {
    
                return Text(snapshot.data.distance);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

