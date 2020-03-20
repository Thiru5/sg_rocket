import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/models/user_location.dart';
import 'package:sg_rocket/services/location_service.dart';
import 'package:sg_rocket/views/home_view.dart';

/*class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _position;
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        _position = currloc;
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              alignment: Alignment.center, width: 115.5, height: 145),
          Align(
              alignment: Alignment.center,
              child: Container(
                  child: Text('Location',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.grey,
                      )))),
          
          FlatButton(
            onPressed: () {},
            child: Text(
              'Change',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            color: Colors.yellow,
          )

        ],
      ),
    );
  }
} 

getPlace(Position _position) async {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  List<Placemark> newPlace = await geolocator.placemarkFromCoordinates(
      _position.latitude, _position.longitude);
  Placemark placeMark = newPlace[0];
  print(placeMark.name);
  /*location.name = placeMark.name;
  location.postalCode = placeMark.postalCode;
  location.country = placeMark.country;*/
} */

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(home: HomeView()));
  }
}