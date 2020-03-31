import 'package:flutter/material.dart';
import 'package:sg_rocket/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TopBar extends StatelessWidget {

  LatLng startLocation;
  LatLng destination;
  String startLocationName;
  String destinationName;
  TopBar({Key key, @required this.destination,this.startLocation,this.startLocationName,this.destinationName}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    if(startLocationName == null)
    {
      startLocationName = 'Proceed Back to Select';
    }

    if(destinationName == null)
    {
      destinationName = 'Proceed Back to Select';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      child: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),
            Row(
              children: <Widget>[
                Text(
                  '  From',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  startLocationName,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                Text(
                  '  To  ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  destinationName,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
