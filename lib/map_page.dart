import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _controller; // Controller for the map
  CameraPosition? _initialCameraPosition;
  Set<Marker> _markers = {};

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error(
          'Location permissions are denied'); // Handle permission denial
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.'); // Handle permanently denied permissions
  }
  return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((position) {
      _initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.0, // Adjust zoom level as needed
    );
    setState(() {}); // Trigger rebuild to update map
    }).catchError((error) {
    // Handle location errors (e.g., show a message to the user)
    print("Error getting location: $error");
    // You might want to set a default location here if location fails.
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: _initialCameraPosition == null 
      ? const Center(child: CircularProgressIndicator()) : GoogleMap(
        initialCameraPosition: _initialCameraPosition!,
        mapType: MapType.normal, // You can change the map type
        markers: _markers, //display markers 
        onMapCreated: (controller) {
          _controller = controller;
          _centerOnCurrentLocation();
        },
        onTap: _addMarker, //add marker on tap
        // Add markers, polylines, etc. here
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _centerOnCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }

  void _centerOnCurrentLocation() {
    _getCurrentLocation().then((position) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.0,
        ),
      ));
    }).catchError((error) {
      print("Error centering on location: $error");
    });
  }

  void _addMarker(LatLng tappedPoint){
    setState((){
      _markers.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),//Unique ID for marker
          position: tappedPoint,
          infoWindow: const InfoWindow(
            title: 'New Place',
            snippet: 'Add description here',
          ),
          icon: BitmapDescriptor.defaultMarker, //You can customize the icon
        ),
      );
    });
  }

}


  




