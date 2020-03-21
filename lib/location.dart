import 'package:geolocator/geolocator.dart';

void GetCurrentPosition() async {
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position);
}
