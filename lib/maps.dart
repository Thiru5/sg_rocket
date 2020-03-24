  import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart' as loc;
import 'package:sg_rocket/map_req.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as poly;

const LatLng SOURCE_LOCATION = LatLng(1.385110, 103.745003);
const LatLng DEST_LOCATION = LatLng(1.2966, 103.7764);

const kGoogleApiKey = "AIzaSyC9sCa6TUJ0PGhkCd3RwOr_R3B850Qpe9I";

void main() => runApp(MapsRoute());

class MapsRoute extends StatefulWidget {
  final String exText;

  const MapsRoute({Key key, @required this.exText}) : super(key: key);
  @override
  _MapsRouteState createState() => _MapsRouteState();

}

class _MapsRouteState extends State<MapsRoute> {


  Completer<GoogleMapController> _controller = Completer();

  bool loading = true;
  static const LatLng _center = const LatLng(1.338231, 103.984072);
  LatLng _lastMapPosition = _center;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  loc.LocationData currentLocation;
  static LatLng latLng;

  @override
  void initState(){
    getLocation();
    loading = true;
    super.initState();
  }

  getLocation() async {
    var location = new loc.Location();
    location.onLocationChanged().listen((currentLocation){
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      print(MapsRoute().exText);
      setState(() {
        latLng = LatLng(currentLocation.latitude,
        currentLocation.longitude);
      });
      print("getLocation:$latLng");
      print("B");
      print(MapsRoute().exText);
      _onAddMarkerButtonPressed();
      loading = false;
    });
  }



  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    latLng = position.target;
  }


  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }


  void sendRequest() async {
    getLocation();
    String route = await _googleMapsServices.getRouteCoordinates(
       latLng , DEST_LOCATION);
    createRoute(route);
    _addMarker(DEST_LOCATION,"Destination");
  }

  void createRoute(String encodedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 8,
        points: _convertToLatLng(_decodePoly(encodedPoly)),
        color: Colors.yellowAccent));

    print(_convertToLatLng(_decodePoly(encodedPoly)));
  }
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueYellow),
    ),
    );
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
            children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            polylines: _polyLines,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: _markers,
            compassEnabled: true,
            myLocationEnabled: true,
            tiltGesturesEnabled: false,
            onCameraMove: _onCameraMove,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.amber[300],
                ),
              )),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.only(top: 40, bottom: 20, right: 20),
              child: FloatingActionButton(
                onPressed: _onAddMarkerButtonPressed,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.amber[300],
                child: const Icon(Icons.add_location, size: 36.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 40, bottom: 20, right: 20),
              child: RaisedButton(
               onPressed: () {
                 getLocation();
                 sendRequest();
                 print("C");
                 print(MapsRoute().exText);

               },
                child: Text(
                  'Request',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    getLocation();
    _onAddMarkerButtonPressed();
  }



  }
