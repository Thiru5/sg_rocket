import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/map_nav.dart';
import 'package:sg_rocket/topbar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/database.dart';
import 'models/routeQuery.dart';

int buttonPressed;
class TransportMenu extends StatefulWidget {
  @override
  _TransportMenuState createState() => _TransportMenuState();
}
blueURL() async{
  String url = 'https://play.google.com/store/apps/details?id=com.bluesg.androidapp&hl=fr';
  if (await canLaunch(url)){
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
grabURL() async{
  String url = 'https://app.appsflyer.com/com.grabtaxi.passenger?pid=MY-Website-ADR-Install_Button&c=Website_Download';
  if (await canLaunch(url)){
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _TransportMenuState extends State<TransportMenu> {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<RouteQuery>>.value(
      value: LocationQuery().routeQuery,
        child: Scaffold(
            body: Stack(
              children: <Widget>[
               Column(
                children: <Widget>[
                  TopBar(),
                  Text(
                      'Choose...',
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: "xx",
                      ),
                    ),
                  SizedBox(
                    height: 600, // constrain height
                    child: Icons(),

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
                            blueURL();
                          } else if (buttonPressed == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MapNavMenu(buttonpressed: buttonPressed)),
                            );
                          } else if (buttonPressed == 2) {
                            grabURL();

                          } else if (buttonPressed == 3) {}
                          else if (buttonPressed == 4) {}
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
        ),
    );
  }
}

class Icons extends StatefulWidget {
  @override
  _IconsState createState() => _IconsState();
}

class _IconsState extends State<Icons> {
  List <int> buttonIndex = [0,0,0,0,0,0];
  @override
  Widget build(BuildContext context) {
    return
      CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(30),
            sliver: SliverGrid.count(
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: <Widget>[
                RaisedButton(
                  padding: const EdgeInsets.all(10),

                  child: Image.asset('assets/elec_button.png'),
                  color: buttonIndex[0] == 1  ? Colors.amber[300] : Colors.white,
                  onPressed: ()
                  {
                    buttonPressed = 0;
                    for (int i = 0; i < 6; i++){
                      if ( buttonIndex[i] == 1){
                        buttonIndex[i] = 0;
                      }
                      if (i == buttonPressed){
                        setState(() { buttonIndex[0] = 1;});
                      }
                    }
                  },
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/pub_trans_button.png'),
                  color: buttonIndex[1] == 1  ? Colors.amber[300] : Colors.white,
                  onPressed: ()
                  {
                    buttonPressed = 1;
                    for (int i = 0; i < 6; i++){
                      if ( buttonIndex[i] == 1){
                        buttonIndex[i] = 0;
                      }
                      if (i == buttonPressed){
                        setState(() { buttonIndex[1] = 1;});
                      }
                    }
                  },
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/private_button.png'),
                  color: buttonIndex[2] == 1  ? Colors.amber[300] : Colors.white,
                  onPressed: ()
                  {
                    buttonPressed = 2;
                    for (int i = 0; i < 6; i++){
                      if ( buttonIndex[i] == 1){
                        buttonIndex[i] = 0;
                      }
                      if (i == buttonPressed){
                        setState(() { buttonIndex[2] = 1;});
                      }
                    }
                  },
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/drive_button.png'),
                  color: buttonIndex[3] == 1  ? Colors.amber[300] : Colors.white,
                  onPressed: ()
                  {
                    buttonPressed = 3;
                    for (int i = 0; i < 6; i++){
                      if ( buttonIndex[i] == 1){
                        buttonIndex[i] = 0;
                      }
                      if (i == buttonPressed){
                        setState(() { buttonIndex[3] = 1;});
                      }
                    }
                  },
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/walk_button.png'),
                  color: buttonIndex[4] == 1  ? Colors.amber[300] : Colors.white,
                  onPressed: ()
                  {
                    buttonPressed = 4;
                    for (int i = 0; i < 6; i++){
                      if ( buttonIndex[i] == 1){
                        buttonIndex[i] = 0;
                      }
                      if (i == buttonPressed){
                        setState(() { buttonIndex[4] = 1;});
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      );
  }
}

