import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:sg_rocket/models/routeQuery.dart';

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {

    final locationQuery = Provider.of<List<RouteQuery>>(context);
    locationQuery.forEach((locationQuery){
      print(locationQuery.endAddress);
    });

    return Container();
  }
}
