import 'package:flutter/material.dart';
import '../shared/utils/hospital_data.dart';
import 'home_screen.dart';
import 'google_maps_handler.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<List<Hospital>> _futureHospitals;

  @override
  void initState() {
    super.initState();
    _futureHospitals = fetchHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Hospitals'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Hospital>>(
          future: _futureHospitals,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No hospitals found');
            } else {
              final hospitals = snapshot.data!;
              return ListView.separated(
                itemCount: hospitals.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (context, index) {
                  final hospital = hospitals[index];
                  return ListTile(
                    title: Text(hospital.name),
                    subtitle: Text('Location: ${hospital.latitude}, ${hospital.longitude}'),
                    onTap: () {
                      GoogleMapsHandler.openGoogleMaps(context, hospital);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
