import 'package:flutter/material.dart';

class OptionMenu extends StatefulWidget {
  @override
  _OptionMenuState createState() => _OptionMenuState();
}

class _OptionMenuState extends State<OptionMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Option Menu',
        home: Scaffold(
          body: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(top: 100),
                    child: Buttons(),
                  )
              ),
              Container(
                padding: EdgeInsets.only(top: 200),
                child:
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    onPressed: () {},
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
          ),
        )
    );
  }
}

class Buttons extends StatefulWidget {
  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  List <int> buttonIndex = [0, 0, 0, 0];
  int buttonPressed;

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
                color: buttonIndex[0] == 1 ? Colors.amber[300] : Colors.white,
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
                child: const Text(
                    'MODE OF TRASNPORT', style: TextStyle(fontSize: 20)),
                color: buttonIndex[0] == 1 ? Colors.amber[300] : Colors.white,
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

                child: const Text(
                    'I HATE PEOPLE', style: TextStyle(fontSize: 20)),
                color: buttonIndex[0] == 1 ? Colors.amber[300] : Colors.white,
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


