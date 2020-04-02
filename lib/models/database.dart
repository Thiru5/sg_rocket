import 'package:sg_rocket/models/routeQuery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LocationQuery {

  final CollectionReference locationCollection = Firestore.instance.collection(
      'locationQuery');

  Future updateLocationQueryData(String startAddress, String endAddress,
      List startPoint, List endPoint) async {
    print('In query fn');
    return await locationCollection.document('routeQuery').setData({
      'startPoint': startPoint,
      'endPoint': endPoint,
      'startAddress': startAddress,
      'endAddress': endAddress,
    });
  }

  List<RouteQuery> _routeQueryFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return RouteQuery(
        startAddress: doc.data['startAddress'] ?? '',
        endAddress: doc.data['endAddress'] ?? '',
        startPoint: doc.data['startPoint'] ?? [0.0,0.0],
        endPoint: doc.data['endPoint'] ?? [0.0,0.0],

      );
    }).toList();

  }


  Stream<List<RouteQuery>> get routeQuery {
    return locationCollection.snapshots().map(_routeQueryFromSnapshot);
  }

}

