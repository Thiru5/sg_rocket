import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/models/user_location.dart';
//import 'package:geocoder/geocoder.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
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
              alignment: Alignment.center, width: 115.5, height: 145),
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
                child: Text(
                    'Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}',
                    style: TextStyle(fontSize: 20.0))),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 160.0),
            child: FlatButton(
            onPressed: () {},
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
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 100.0),
          ),
        Container (
          width: 70,
          height: 70,
          child: FlatButton(
            onPressed: () {},
            child: Text("Confirm"),
            color: Colors.amber[300],
            shape: CircleBorder(side: BorderSide(width: 2, color: Colors.amber[300], style: BorderStyle.solid)),
          )
        )
        ],
      ),
    );
  }
}
