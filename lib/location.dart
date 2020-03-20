/* import 'package:geolocator/geolocator.dart';

getPlace(Position _position) async {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  List<Placemark> newPlace = await geolocator.placemarkFromCoordinates(
      _position.latitude, _position.longitude);
  Placemark placeMark = newPlace[0];
  print(placeMark.name);
  /*location.name = placeMark.name;
  location.postalCode = placeMark.postalCode;
  location.country = placeMark.country;*/
} */