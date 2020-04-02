import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:provider/provider.dart';

import 'models/routeQuery.dart';

class RouteTileList extends StatefulWidget {
  @override
  _RouteTileListState createState() => _RouteTileListState();
}

class _RouteTileListState extends State<RouteTileList> {
  @override
  Widget build(BuildContext context) {
    String startAdd;
    String endAdd;

    final locationQuery = Provider.of<List<RouteQuery>>(context);
    final items = List<String>.generate(10000, (i) => "Item $i");

    return ListView.builder(
      itemCount: locationQuery.length,
      itemBuilder: (context,index){
        return ListTile(
          title: Text('${[locationQuery[index].endAddress,locationQuery[index].endPoint]}'),
          subtitle: Text('${[locationQuery[index].startAddress,locationQuery[index].startPoint]}'),
        );
      },
    );
  }
}
