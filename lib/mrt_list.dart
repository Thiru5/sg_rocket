import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'fare_calculation.dart';

class MrtList extends StatelessWidget {
  final List<Mrt> mrtList;
  MrtList({Key key, this.mrtList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mrtPrice;
    for (int index = 0; index <mrtList.length; index++) {
      mrtPrice = mrtList[index].code;
    }
    return Center();
  }
}
