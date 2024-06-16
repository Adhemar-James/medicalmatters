import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../shared/utils/hospital_data.dart'; // Ensure the path is correct

class GoogleMapsHandler {
  static void openGoogleMaps(BuildContext context, Hospital hospital) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => YourGoogleMapsScreen(hospital: hospital),
      ),
    );
  }
}

class YourGoogleMapsScreen extends StatefulWidget {
  final Hospital? hospital; // Make hospital optional by adding "?" after the type

  const YourGoogleMapsScreen({super.key, this.hospital});

  @override
  _YourGoogleMapsScreenState createState() => _YourGoogleMapsScreenState();
}


class _YourGoogleMapsScreenState extends State<YourGoogleMapsScreen> {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId(widget.hospital!.id),
        position: LatLng(widget.hospital!.latitude, widget.hospital!.longitude),
        infoWindow: InfoWindow(title: widget.hospital?.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hospital!.name),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.hospital!.latitude, widget.hospital!.longitude),
          zoom: 15,
        ),
        markers: _markers,
      ),
    );
  }
}
