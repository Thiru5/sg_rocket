import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:sg_rocket/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:sg_rocket/maps.dart';
import 'package:sg_rocket/location.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text('Normal',
                  style: TextStyle(color: Colors.green)),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 160.0),
            child: FlatButton(
              onPressed: _handlePressButton,
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
            child: TextField(
              onTap: ()async{
                Prediction p = await PlacesAutocomplete.show(context: context, apiKey: kGoogleApiKey, language: "en", components:[
                  Component(Component.country, "sg")
                ]);
                displayPrediction(p, homeScaffoldKey.currentState);
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
              width: 70,
              height: 70,
              child: FlatButton(
                onPressed: () {},
                child: Text("Confirm"),
                color: Colors.amber[300],
                shape: CircleBorder(
                    side: BorderSide(
                        width: 2,
                        color: Colors.amber[300],
                        style: BorderStyle.solid)),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 160.0),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapsRoute())
                );
              },
              child: Text(
                'Maps',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              color: Colors.amber[300],
            ),
          ),
        ],
      ),
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      language: "en",
      components: [Component(Component.country, "sg")],
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}



class LoadUpImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/load_up.png');
    Image image = Image(image: assetImage);
    return Container(child: image);
  }
}