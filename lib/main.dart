import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;
import 'package:sg_rocket/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sg_rocket/option_menu.dart';
import 'package:sg_rocket/topbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

import 'bus_load.dart';

const kGoogleApiKey = "AIzaSyC9sCa6TUJ0PGhkCd3RwOr_R3B850Qpe9I";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  LatLng location;
  LatLng destination;
  HomePage({Key key, @required this.destination, this.location})
      : super(key: key);
  @override
  _HomePageState createState() => _HomePageState(destination,location);
}

class _HomePageState extends State<HomePage> {
  Prediction predict;
  LatLng destination;
  LatLng location;
  _HomePageState(this.destination,this.location);

  bool loading = true;
  loc.LocationData nowLocation;
  static LatLng latLng;
  static LatLng desLng;

  static String destName;
  static String startName;


  @override
  void initState() {
    getLocation();
    super.initState();
  }

  getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(position);

    setState(() {
      latLng = LatLng(position.latitude, position.longitude);
      if(location!=latLng && location!=null)
        {
          latLng = location;
        }
      if(destination != null){
        desLng = LatLng(destination.latitude,destination.longitude);
      }
      else{
        desLng = LatLng(0.00,0.00);
      }
      convertCoordinateToPlace();
    });
  }

  convertCoordinateToPlace() async {
    List<Address> placeName = await Geocoder.local.findAddressesFromCoordinates(Coordinates(latLng.latitude,latLng.longitude));
    var startReply = placeName.first;

    List<Address> endName = await Geocoder.local.findAddressesFromCoordinates(Coordinates(desLng.latitude,desLng.longitude));
    var destReply = endName.first;

    setState(() {
      startName = "${startReply.addressLine}"; //startReply.name +' '+ startReply.subLocality +' '+ startReply.locality +' '+ startReply.administrativeArea +' '+ startReply.postalCode +' '+ startReply.country;
      destName = "${destReply.addressLine}";//destReply.name  +' '+ destReply.subLocality +' '+ destReply.locality+' '+ destReply.administrativeArea +' '+ destReply.postalCode +' '+ destReply.country;
    });

  }

  @override
  Widget build(BuildContext context) {

    String checkForStartNameNull() {
      if(startName != null){
        return startName;
      }
      else{
        return 'Your Location';
      }
    }

    String checkForDestNameNull() {
      if(destName != null){
        return destName;
      }
      else{
        return 'Requires Destination Input';
      }
    }

    String startStr = checkForStartNameNull();
    String destStr = checkForDestNameNull();
    return new Scaffold(
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(top: 60, bottom: 20),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  //fontFamily: "xx",
                ),
              ),
            ),
          ),
          Image.asset('assets/location.png',
              alignment: Alignment.center, width: 50.0, height: 100),
          Align(
              alignment: Alignment.center,
              child: Container(
                  child: Text('Location',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.grey,
                      )))),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 30, 30),
              child: Text(startStr,
                  style: TextStyle(color: Colors.green),
              textAlign: TextAlign.center,),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 160.0),
            child: FlatButton(
              onPressed: () async {
                Prediction p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: kGoogleApiKey,
                    language: "en",
                    components: [Component(Component.country, "sg")]);
                PlacesDetailsResponse response =
                    await _places.getDetailsByPlaceId(p.placeId);
                var location = response.result.geometry.location;
                Navigator.push(context,
                MaterialPageRoute(
                  builder:(context) => HomePage(
                    location: LatLng(location.lat, location.lng),
                    destination: desLng,
                  )
                ));
              },
              child: Text(
                'Change',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              color: Colors.amber[300],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: TextFormField(
              onTap: () async {
                Prediction p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: kGoogleApiKey,
                    language: "en",
                    components: [Component(Component.country, "sg")]);
                PlacesDetailsResponse response =
                    await _places.getDetailsByPlaceId(p.placeId);
                var location = response.result.geometry.location;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              destination: LatLng(location.lat, location.lng),
                              location: latLng,
                            )));
              },
              decoration: new InputDecoration(
                fillColor: Colors.amber[100],
                filled: true,
                hintText: "Enter Destination",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[200], width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[200], width: 3.0),
                ),
              ),
            ),
            padding: EdgeInsets.only(
                left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Text(destStr, style: TextStyle(color: Colors.green),
                textAlign: TextAlign.center,),
            ),
          ),
        ],
      ),
    floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Text("Confirm",
            style: TextStyle(
              color: Colors.black,
              fontSize: 9.0,
            )),
            backgroundColor: Colors.amber[300],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OptionMenu(
                  startLocation: latLng,
                  destination: desLng,
                  startLocationName: startStr,
                  destinationName: destStr,
                )),

              );
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TopBar(
                startLocation: latLng,
                destination: desLng,
                startLocationName: startStr,
                destinationName: destStr,
              )),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: Container(
//        height: 80.0,
//        width: 80.0,
//        child: FittedBox(
//          child: FloatingActionButton(
//            child: Icon(Icons.navigation),
//            backgroundColor: Colors.amber[300],
//            onPressed: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => MapsRoute(
//                            destination: finalDest,
//                            location: latLng,
//                          )));
//            },
//          ),
//        ),
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }
}
