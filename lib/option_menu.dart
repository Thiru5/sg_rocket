import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/display_route_ui.dart';
import 'package:sg_rocket/fare_calculation.dart';
import 'package:sg_rocket/map_nav.dart';
import 'package:sg_rocket/models/database.dart';
import 'package:sg_rocket/transport_mode.dart';
import 'package:sg_rocket/topbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bus_stops.dart';

import 'models/routeQuery.dart';

int buttonPressed;

class OptionMenu extends StatefulWidget {
  LatLng startLocation;
  LatLng destination;
  String startLocationName;
  String destinationName;
  OptionMenu({Key key, @required this.destination,this.startLocation,this.startLocationName,this.destinationName}) : super(key: key);
  @override
  @override
  _OptionMenuState createState() => _OptionMenuState(startLocation,destination,startLocationName,destinationName);
}

class _OptionMenuState extends State<OptionMenu> {
  LatLng destination;
  LatLng startLocation;
  String startLocationName;
  String destinationName;
  _OptionMenuState(this.destination,this.startLocation,this.startLocationName,this.destinationName);

  @override
  Widget build(BuildContext context) {


    if(startLocationName == null)
      {
        startLocationName = 'Proceed Back to Select';
      }

    if(destinationName == null)
    {
      destinationName = 'Proceed Back to Select';
    }

    return StreamProvider<List<RouteQuery>>.value(
          value: LocationQuery().routeQuery,
          child: Scaffold(
            body: Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TopBar(),
                      Buttons(),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      height: 120.0,
                      width: 120.0,
                      child: FittedBox(
                        child: FloatingActionButton(
                          child: Text("Confirm",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 9.0,
                              )),
                          backgroundColor: Colors.amber[300],
                          onPressed: () {

                            if (buttonPressed == 0) {
                              print('oof');
                              
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => fareCalculate()),
                              );

                            } else if (buttonPressed == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MapNavMenu(buttonpressed: buttonPressed)),
                              );
                            } else if (buttonPressed == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransportMenu()),
                              );
                            } else if (buttonPressed == 3) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BusStops()),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ));
    }
  }

class Buttons extends StatefulWidget {
  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  List<int> buttonIndex = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          'Choose...',
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontFamily: "xx",
          ),
        ),
        ButtonTheme(
          minWidth: 250,
          height: 35,
          child: RaisedButton(
            child: const Text('FASTEST', style: TextStyle(fontSize: 20)),
            color: buttonIndex[0] == 1 ? Colors.amber[300] : Colors.white,
            onPressed: () {
              buttonPressed = 0;
              for (int i = 0; i < 4; i++) {
                if (buttonIndex[i] == 1) {
                  buttonIndex[i] = 0;
                }
                if (i == buttonPressed) {
                  setState(() {
                    buttonIndex[0] = 1;
                  });
                }
              }
            },
          ),
        ),
        ButtonTheme(
          minWidth: 250,
          height: 35,
          child: RaisedButton(
            child: const Text('CHEAPEST', style: TextStyle(fontSize: 20)),
            color: buttonIndex[1] == 1 ? Colors.amber[300] : Colors.white,
            onPressed: () {
              buttonPressed = 1;
              for (int i = 0; i < 4; i++) {
                if (buttonIndex[i] == 1) {
                  buttonIndex[i] = 0;
                }
                if (i == buttonPressed) {
                  setState(() {
                    buttonIndex[1] = 1;
                  });
                }
              }
            },
          ),
        ),
        ButtonTheme(
          minWidth: 250,
          height: 35,
          child: RaisedButton(
            child:
                const Text('MODE OF TRASNPORT', style: TextStyle(fontSize: 20)),
            color: buttonIndex[2] == 1 ? Colors.amber[300] : Colors.white,
            onPressed: () {
              buttonPressed = 2;
              for (int i = 0; i < 4; i++) {
                if (buttonIndex[i] == 1) {
                  buttonIndex[i] = 0;
                }
                if (i == buttonPressed) {
                  setState(() {
                    buttonIndex[2] = 1;
                  });
                }
              }
            },
          ),
        ),
        ButtonTheme(
          minWidth: 250,
          height: 35,
          child: RaisedButton(
            child: const Text('I HATE PEOPLE', style: TextStyle(fontSize: 20)),
            color: buttonIndex[3] == 1 ? Colors.amber[300] : Colors.white,
            onPressed: () {
              buttonPressed = 3;
              for (int i = 0; i < 4; i++) {
                if (buttonIndex[i] == 1) {
                  buttonIndex[i] = 0;
                }
                if (i == buttonPressed) {
                  setState(() {
                    buttonIndex[3] = 1;
                  });
                }
              }
            },
          ),
        ),
      ],
    )
  );
  }
}
