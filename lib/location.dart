import 'package:geolocator/geolocator.dart';

void getCurrentPosition() async {
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position);
}
