
class Response{
  List geocoded_waypoints;
  Routes routes;
  String status;
  Response({this.geocoded_waypoints,this.routes,this.status});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(geocoded_waypoints: json["geocoded_waypoints"] as List,
    routes: json["routes"] as Routes,
    status: json["status"] as String);
  }
}

class Routes{
  Bounds1 bounds;
  String copyrights;
  Legs legs;
  Routes({
    this.bounds,
    this.copyrights,
    this.legs
  });

  factory Routes.fromjson(Map<String, dynamic> json){
    return Routes(bounds: json["bounds"] as Bounds1,
    copyrights: json["copyrights"] as String,
    legs: json["legs"] as Legs);
  }

}
class Bounds1{
  NE northeast;
  SW southwest;
  Bounds1({this.northeast,this.southwest});

  factory Bounds1.fromjson(Map<String, dynamic> json){
    return Bounds1(northeast: json["northeast"] as NE,
    southwest: json["southwest"] as SW);
  }
}
class NE{
  double lat;
  double lng;
  NE({this.lat,this.lng});

  factory NE.fromjson(Map<String, dynamic> json){
    return NE(lat: json["lat"] as double,
    lng: json["lng"] as double);
  }
}
class SW{
  double lat;
  double lng;
  SW({this.lat,this.lng});

  factory SW.fromjson(Map<String, dynamic> json){
    return SW(lat: json["lat"] as double,
    lng: json["lng"] as double);
  }
}
class Legs{
  Arrival_Time arrival_time;
  Departure_Time departure_time;
  Distance distance;
  Duration duration;
  String end_address;
  End_Location end_location;
  String start_address;
  Start_Location start_location;
  Steps steps;
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
  factory Legs.fromjson(Map<String, dynamic> json){
    return Legs(arrival_time: json["arrival_time"] as Arrival_Time,
    departure_time: json["departure_time"] as Departure_Time,
    distance: json["distance"] as Distance,
    duration: json["duration"] as Duration,
    end_address: json["end_address"] as String,
    end_location: json["end_location"] as End_Location,
    start_address: json["start_address"] as String,
    start_location: json["start_location"] as Start_Location,
    steps: json["steps"] as Steps,
    traffic_speed_entry: json["traffic_speed_entry"] as List,
    via_waypoint: json["via_waypoint"] as List);
  }
}

class Arrival_Time{
  String text;
  String time_zone;
  int value;
  Arrival_Time({this.text, this.time_zone, this.value});
  factory Arrival_Time.fromjson(Map<String, dynamic> json){
    return Arrival_Time(text: json["text"] as String,
    time_zone: json["time_zone"] as String,
    value: json["value"] as int);
  }
}
class Departure_Time {
  String text;
  String time_zone;
  int value;
  Departure_Time({this.text, this.time_zone, this.value});
  factory Departure_Time.fromjson(Map<String, dynamic> json){
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
    steps: json["steps"] as Steps,
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
