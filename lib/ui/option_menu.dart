import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/ui/sortByTime.dart';
import 'package:sg_rocket/ui/sortByCrowd.dart';
import 'package:sg_rocket/ui/map_nav.dart';
import 'package:sg_rocket/models/database.dart';
import 'package:sg_rocket/ui/sortByTransport.dart';
import 'package:sg_rocket/ui/topbar.dart';
import '../models/routeQuery.dart';

int buttonPressed;

class OptionMenu extends StatefulWidget {
  @override
  _OptionMenuState createState() => _OptionMenuState();
}

class _OptionMenuState extends State<OptionMenu> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RouteQuery>>.value(
        value: LocationQuery().routeQuery,
        child: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TopBar(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 100, 20, 100),
                      child:Buttons(),
                    ),

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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SortByTime(buttonpressed: buttonPressed,),
                                ));
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
                                  builder: (context) => SortByTransport(buttonpressed: buttonPressed)),
                            );
                          } else if (buttonPressed == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SortByCrowd(buttonpressed: buttonPressed)),
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
            fontSize: 30,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontFamily: "xx",
          ),
        ),
        ButtonTheme(
          minWidth: 400,
          height: 40,
          child: RaisedButton(
            child: const Text('FASTEST', style: TextStyle(fontSize: 15)),
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
          minWidth: 400,
          height: 40,
          child: RaisedButton(
            child: const Text('CHEAPEST', style: TextStyle(fontSize: 15)),
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
          minWidth: 400,
          height: 40,
          child: RaisedButton(
            child:
                const Text('MODE OF TRANSPORT', style: TextStyle(fontSize: 15)),
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
          minWidth: 400,
          height: 40,
          child: RaisedButton(
            child: const Text('I HATE PEOPLE', style: TextStyle(fontSize: 15)),
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
    ));
  }
}
