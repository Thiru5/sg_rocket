import 'package:flutter/material.dart';
import 'package:sg_rocket/map_nav.dart';
import 'package:sg_rocket/topbar.dart';


class TransportMenu extends StatefulWidget {
  @override
  _TransportMenuState createState() => _TransportMenuState();
}

class _TransportMenuState extends State<TransportMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Transport Menu',
        home: Scaffold(
            body: Column(
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
                  height: 450, // constrain height

                  child: Icons(),

                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child:
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RawMaterialButton(
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapNavMenu()),
                          );
                        },
                      child: const Text('Confirm', style: TextStyle(fontSize: 20)),
                      fillColor: Colors.amber[300],
                      shape: CircleBorder(
                          side: BorderSide(
                              width: 2,
                              color: Colors.amber[300],
                              style: BorderStyle.solid)),
                      padding: EdgeInsets.all(25),
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}

class Icons extends StatefulWidget {
  @override
  _IconsState createState() => _IconsState();
}

class _IconsState extends State<Icons> {
  List <int> buttonIndex = [0,0,0,0,0,0];
  int buttonPressed;
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

