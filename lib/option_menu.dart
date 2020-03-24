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
//          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.end,
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

class Buttons extends StatelessWidget{
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
                onPressed: () {},
                child: const Text('FASTEST', style: TextStyle(fontSize: 20)),
                color: Colors.amber[300],
              ),
            ),
            ButtonTheme(
              minWidth: 250,
              height: 35,
              child: RaisedButton(
                onPressed: () {},
                child: const Text('CHEAPEST', style: TextStyle(fontSize: 20)),
                color: Colors.amber[300],
              ),
            ),
            ButtonTheme(
              minWidth: 250,
              height: 35,
              child: RaisedButton(
                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => TransportMenu()),
//                  );
                },
                child: const Text('MODE OF TRASNPORT', style: TextStyle(fontSize: 20)),
                color: Colors.amber[300],
              ),
            ),
            ButtonTheme(
              minWidth: 250,
              height: 35,
              child: RaisedButton(
                onPressed: () {},
                child: const Text('I HATE PEOPLE', style: TextStyle(fontSize: 20)),
                color: Colors.amber[300],
              ),
            ),
          ],
        )
    );
  }


}