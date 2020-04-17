
class BusStop {
  final String code;
  final String description;
  final double lat;
  final double lng;
  final String roadName;


  BusStop({this.code, this.description, this.lat, this.lng, this.roadName});

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return new BusStop(
      code: json['BusStopCode'] as String,
      description: json['Description'] as String,
      lat: json['Latitude'] as double,
      lng: json['Longitude'] as double,
      roadName: json['RoadName'] as String,
    );
  }
}