

import 'package:sg_rocket/bus_load.dart';

class Bus{

  Future<Album> futureAlbum = fetchAlbum('83139');

  void getBusCode(){}

  void getBusLoad(snapshot){
    if (snapshot.hasData) {
      var load = new List();
      print(snapshot.data.services.length);
      for (int i = 0; i < snapshot.data.services.length; i++ ){
        var map = new Map();
        map['NextBus'] = snapshot.data.services[i]['NextBus']['Load'];
        map['NextBus2'] = snapshot.data.services[i]['NextBus']['Load'];
        map['NextBus3'] = snapshot.data.services[i]['NextBus']['Load'];
        load.add([snapshot.data.services[i]['ServiceNo'] ,map]);
      }
      print(load);
  }
}



}
