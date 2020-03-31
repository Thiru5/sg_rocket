import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:sg_rocket/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:sg_rocket/maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Prediction predict;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng finalDest;
    LatLng startLoc;
    String startStr = 'Normal';
    String destStr = 'Normal';

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
              child: Text(startStr, style: TextStyle(color: Colors.green)),
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
                var latLng = LatLng(location.lat, location.lng);
                startLoc = latLng;
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
                var latLng = LatLng(location.lat, location.lng);
                finalDest = latLng;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapsRoute(
                          destination: finalDest,
                          location: startLoc,
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
                left: 30.0, right: 30.0, top: 20.0, bottom: 140.0),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(destStr, style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.navigation),
            backgroundColor: Colors.amber[300],
            onPressed: () {

            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }
}
