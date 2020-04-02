import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;


class Directions extends StatefulWidget {
  @override
  _DirectionsState createState() => _DirectionsState();
}

class _DirectionsState extends State<Directions> {
  String output;

  void initState(){
    loadAsset();
  }

  Future<String> loadAsset() async {
    final mapNav = await rootBundle.loadString('assets/map_nav.json');
    final decodedNav = json.decode(mapNav);

    print('${decodedNav.runtimeType}:$decodedNav');

    var routes = decodedNav['routes'][2]['legs'];
    print('$routes');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MapNav Query'),
        ),
        body: Container(child: Center(child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[Text('$output')],
              ),
            );
          },
          itemCount: output.length,
        ))));
  }
}
