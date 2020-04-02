import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class HawkerQuery extends StatefulWidget {
  @override
  _HawkerQueryState createState() => _HawkerQueryState();
}

class _HawkerQueryState extends State<HawkerQuery> {
  List data;
  String output;

  void initState() {
    loadAsset();
  }

  Future<String> loadAsset() async {
    final hawker = await rootBundle.loadString('assets/hawker-centres.json');
//    print(hawker);
    final decodedHawker = json.decode(hawker);
    output = decodedHawker['features'][1]['properties']['Description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HawkerQuery'),
        ),
        body: Container(child: Center(child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[Text(output)],
              ),
            );
          },
        ))));
  }
}
