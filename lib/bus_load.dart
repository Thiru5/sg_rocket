import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const datamallKey = 'OfEb2EVVR1COa5zuW7md3w==';

Future<Album> fetchAlbum(String code) async {

  String url = 'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=' + code;
  Map<String, String> headers = {
    "AccountKey": datamallKey,
  };
  var response = await http.get(
    url,
    headers: headers,
  );
  int statusCode = response.statusCode;
  final responseJson = json.decode(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(Album.fromJson(json.decode(response.body)));
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.

    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;
  String oda;
  final List services;
  final String bus;

  Album({this.userId, this.id, this.title, oda, this.services, this.bus});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(

      oda: json['odata.metadata'],
      services: json['Services'],
      bus: json['BusStopCode'],

    );
  }
}

class BusLoad extends StatefulWidget {
  final String busCode;
  BusLoad({this.busCode});
  @override
  _MyAppState createState() => _MyAppState(busCode: busCode);
}

class _MyAppState extends State<BusLoad > {
  final String busCode;
  _MyAppState({this.busCode});
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(busCode);
//    futureAlbum = fetchAlbum();
  }

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
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.hasData) {
                var load = new List();
                for (int i = 0; i < snapshot.data.services.length; i++ ){
                  var map = new Map();
                  map['NextBus'] = snapshot.data.services[i]['NextBus']['Load'];
                  map['NextBus2'] = snapshot.data.services[i]['NextBus']['Load'];
                  map['NextBus3'] = snapshot.data.services[i]['NextBus']['Load'];
                  load.add([snapshot.data.services[i]['ServiceNo'] ,map]);
                }

                Text(load[0][0] + load[0][1]['NextBus']);
                return new ListView(
                  children: new List.generate(load.length, (index) => new Text(load[index][0] + load[index][1]['NextBus']),
                  ),
                );

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
