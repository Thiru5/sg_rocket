import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sg_rocket/bus_load.dart';

import 'package:http/http.dart' as http;

import 'new_display_route.dart';

class DisplayRoutes extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<DisplayRoutes> {
  List data;
  Future<Response> routes;

  @override
  void initState() {
    super.initState();
    routes = loadStudent();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          child: new Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: new FutureBuilder(
                // future: DefaultAssetBundle.of(context)
                //     .loadString('assets/map_nav.json'),
                future: routes,
                builder: (context, snapshot) {
                  print(snapshot);
              if (snapshot.hasData) {

                return Text('YAY!!!');
            
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
                  print('is this working2?');
                  // List<Routes> routes = parseJson(snapshot.data.toString());
                  print('is this working?');
                  // print('test, '+ routes.toString());
                  // return routes.isNotEmpty
                  //     ? new RouteList(routeList: routes,)
                  //     : new Center(child: new CircularProgressIndicator());
                }),
          ),
        ));
  }

  // List<Routes> parseJson(String response) {
  //   if(response==null){
  //     return [];
  //   }
  //   // final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
  //   final parsed = json.decode(response.toString());
  //   return parsed.map<Routes>((json) => new Routes.fromJson(json)).toList();
  //
  Future<dynamic> _loadAStudentAsset() async {
  return await rootBundle.loadString('assets/map_nav.json');
}

//   Future<Response> loadStudent() async {
//   // String jsonString = await _loadAStudentAsset();
//   var jsonString = await rootBundle.loadString('assets/map_nav.json');
//   final jsonResponse = json.decode(jsonString);
//   Response student = new Response.fromJson(jsonResponse);
//   print(Response.fromJson(jsonResponse).status);
//   return Response.fromJson(jsonResponse);

// }

  Future<Response> loadStudent() async{
    var response = await http.get('https://maps.googleapis.com/maps/api/directions/json?origin=1.3478829,103.6839638&destination=1.3529174,103.6801391&alternatives=true&mode=transit&key=AIzaSyC9sCa6TUJ0PGhkCd3RwOr_R3B850Qpe9I' );
    int statusCode = response.statusCode;
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(2);
    // Response response2 = parseResponse(response.body); 
    print(3);
    print(Response.fromJson(json.decode(response.body)).geocoded_waypoints); 
    print(4); 
    // print(response2.geocoded_waypoints);
    return Response.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.

    throw Exception('Failed to load Response');
  }
  }
   static Response parseResponse (String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
    return parsed.map<Response>((json) =>Response.fromJson(json));
   }
}
