import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bus_stops.dart';
import 'bus_load.dart';


class BusList extends StatelessWidget {
  final List<BusStop> busList;
  BusList({Key key, this.busList}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    String busStop;
    for (int index = 0; index <busList.length; index++) {
      if (busList[index].lat.toStringAsFixed(6) == 1.349022.toString() &&
          busList[index].lng.toStringAsFixed(5) == 103.68539.toString()) {
        busStop = busList[index].code;
      }
    }
    return BusLoad(busCode: busStop,);
  }
}
