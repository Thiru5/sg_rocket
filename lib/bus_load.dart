import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const datamallKey = 'OfEb2EVVR1COa5zuW7md3w==';

Future<Album> fetchAlbum() async {

  String url = 'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=83139';
  Map<String, String> headers = {
    "AccountKey": datamallKey,
  };
  var response = await http.get(
    url,
    headers: headers,
  );

  int statusCode = response.statusCode;

  final responseJson = json.decode(response.body);

  if (statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final List services;
  final String busCode;

  Album({this.services, this.busCode});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      services: json['Services'],
      busCode: json['BusStopCode'],
    );
  }
}