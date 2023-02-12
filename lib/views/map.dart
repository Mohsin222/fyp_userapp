import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


const LatLng currentLocation = LatLng(25.1193, 55.3773);
class Directionss extends StatefulWidget {
  const Directionss({super.key});

  @override
  State<Directionss> createState() => _DirectionssState();
}

class _DirectionssState extends State<Directionss> {
  late GoogleMapController mapController;
  Map<String ,Marker> _markers={};

    addMarker({required String id, required LatLng location}){
  var marker  =Marker(markerId: MarkerId(id),
  position: location,
  infoWindow: InfoWindow(
    title: 'Title of place',
    snippet: 'Some Description of this place'

  )
  );

  _markers[id] = marker;
  setState(() {
    
  });
  }



  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(child: ElevatedButton(child: Text('MAP'),onPressed: (){
MapUtils.openMap(24.914015, 67.106898);

      },),)
    );
  }


}


class MapUtils{
  MapUtils._();

  static Future<void> openMap(double latitude , double longitude)async{
    String googleMapUrl= "https://www.google.com/search/?api=1&query=$latitude,$longitude";

    if(await canLaunch(googleMapUrl)){
      await launch(googleMapUrl);
      
    }else{
      throw 'Could not open the map';
    }
  }
}