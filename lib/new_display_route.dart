import 'package:google_maps_flutter/google_maps_flutter.dart';

class Response{
  final List<GeoCodedwaypoints> geocoded_waypoints;
  final List <Routes> routes;
  String status;
  Response({this.geocoded_waypoints,this.routes,this.status});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
    geocoded_waypoints: parseGeoCoded(json),
    routes: json["routes"],
    status: json["status"]);
  }


static List<GeoCodedwaypoints> parseGeoCoded( geoCodedJson){
  var list = geoCodedJson['geocoded_waypoints'] as List; 
  List <GeoCodedwaypoints> geoCodedList = list.map((data) => GeoCodedwaypoints.fromJson(data)).toList();
  return geoCodedList; 
}
}

class GeoCodedwaypoints{
  final String geocoder_status;
  final String place_id;
  final List<String> types;
  const GeoCodedwaypoints({this.geocoder_status,this.place_id,this.types});

  factory GeoCodedwaypoints.fromJson(Map<String, dynamic> parsedJson){
    return GeoCodedwaypoints(geocoder_status: parsedJson['geocoder_status'], place_id: parsedJson['place_id'], types: parsedJson['types']);
  }
}
 
class Routes{
  Bounds1 bounds;
  String copyrights;
  Legs legs;
  OverviewPolyline overviewPolyline; 
  String summary; 
  List viaWaypoint; 
  Routes({
    this.bounds,
    this.copyrights,
    this.legs
  });

  factory Routes.fromjson(Map<String, dynamic> parsedjson){
    return Routes(
      bounds: Bounds1.fromJson(parsedjson["bounds"]),
      copyrights: parsedjson["copyrights"] ,
      legs: parsedjson["legs"]
    );
  }  

  static List<Legs> parseLegs( legsJson){
  var list = legsJson['legs'] as List; 
  List <Legs> legsList = list.map((data) => Legs.fromJson(data)).toList();
  return legsList; 
}
}

class OverviewPolyline{
  final String point; 
  const OverviewPolyline({this.point});

  factory OverviewPolyline.fromjson(Map<String, dynamic> json){
    return OverviewPolyline(point: json["points"]
    );
  }
}

class Bounds1{
  LatLng northeast;
  LatLng southwest;
  Bounds1({this.northeast,this.southwest});

  factory Bounds1.fromJson(Map<String, dynamic> json){
    return Bounds1(
      northeast: json["northeast"] ,
      southwest: json["southwest"]);
  }
}
// class NE{
//   double lat;
//   double lng;
//   NE({this.lat,this.lng});

//   factory NE.fromjson(Map<String, dynamic> json){
//     return NE(lat: json["lat"] as double,
//     lng: json["lng"] as double);
//   }
// }
// class SW{
//   double lat;
//   double lng;
//   SW({this.lat,this.lng});

//   factory SW.fromjson(Map<String, dynamic> json){
//     return SW(lat: json["lat"] as double,
//     lng: json["lng"] as double);
//   }
// }


class Legs{
  Arrival_Time arrival_time;
  Departure_Time departure_time;
  Distance distance;
  Duration duration;
  String end_address;
  End_Location end_location;
  String start_address;
  Start_Location start_location;
  List<Steps> steps;
  List traffic_speed_entry;
  List via_waypoint;
  Legs({this.arrival_time,
  this.departure_time,this.distance,this.duration,
  this.end_address,this.end_location,
  this.start_address,
  this.start_location,
  this.steps,
  this.traffic_speed_entry,
  this.via_waypoint});
  factory Legs.fromJson(Map<String, dynamic> json){
    return Legs(
    arrival_time: Arrival_Time.fromJson(json["arrival_time"]),
    departure_time: Departure_Time.fromJson(json["departure_time"]),
    distance: Distance.fromjson(json["distance"]),
    duration: Duration.fromjson(json["duration"]),
    end_address: json["end_address"],
    end_location: End_Location.fromjson(json["end_location"]),
    start_address: json["start_address"] as String,
    start_location: Start_Location.fromjson(json["start_location"]),
    steps: json["steps"],
    traffic_speed_entry: json["traffic_speed_entry"],
    via_waypoint: json["via_waypoint"] as List);
  }
  static List<Steps> parseSteps( stepsJson){
  var list = stepsJson['legs'] as List; 
  List <Steps> stepsList = list.map((data) => Steps.fromjson(data)).toList();
  return stepsList;
  }
}

class Arrival_Time{
  String text;
  String time_zone;
  int value;
  Arrival_Time({this.text, this.time_zone, this.value});
  factory Arrival_Time.fromJson(Map<String, dynamic> json){
    return Arrival_Time(
      text: json["text"] as String,
      time_zone: json["time_zone"] as String,
      value: json["value"] as int);
  }
}
class Departure_Time {
  String text;
  String time_zone;
  int value;
  Departure_Time({this.text, this.time_zone, this.value});
  factory Departure_Time.fromJson(Map<String, dynamic> json){
    return Departure_Time(text: json["text"] as String,
    time_zone: json["time_zone"] as String,
    value: json["value"] as int);
  }
}
class Distance{
  String text;
  int value;
  Distance({this.text, this.value});
  factory Distance.fromjson(Map<String, dynamic> json){
    return Distance(text: json["text"] as String,
    value: json["value"] as int);
  }
}
class Duration{
  String text;
  int value;
  Duration({this.text, this.value});
  factory Duration.fromjson(Map<String, dynamic> json){
    return Duration(text: json["text"] as String,
    value: json["value"] as int);
  }
}
class End_Location{
  double lat;
  double lng;
  End_Location({this.lat,this.lng});
  factory End_Location.fromjson(Map<String, dynamic> json){
    return End_Location(lat: json["lat"] as double,
    lng: json["lng"] as double);
  }
}
class Start_Location{
  double lat;
  double lng;
  Start_Location({this.lat,this.lng});
  factory Start_Location.fromjson(Map<String, dynamic> json){
    return Start_Location(lat: json["lat"] as double,
    lng: json["lng"] as double);
  }
}

class Steps{
  Distance distance;
  Duration duration;
  End_Location end_location;
  String html_instructions;
  Polyline1 polyline;
  Start_Location start_location;
  Steps steps;
  String travel_mode;
  Steps({this.distance,this.duration,this.end_location,
  this.html_instructions,this.polyline,this.start_location,
  this.steps,this.travel_mode});
  factory Steps.fromjson(Map<String, dynamic> json){
    return Steps(distance: json["distance"] as Distance,
    duration: json["duration"] as Duration,
    end_location: json["end_location"] as End_Location,
    html_instructions: json["html_instructions"] as String,
    polyline: json["polyline"] as Polyline1,
    start_location: json["start_location"] as Start_Location,
    steps: json["steps"],
    travel_mode: json["travel_mode"] as String);
  }
}
class Polyline1{
  String points;
  Polyline1({this.points});
  factory Polyline1.fromjson(Map<String, String> json){
    return Polyline1(points: json["points"]);
  }
}
