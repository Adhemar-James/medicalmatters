import 'dart:convert';
import 'package:http/http.dart' as http;

// Define the Hospital class
class Hospital {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Hospital({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    final centroid = json['centroid'] ?? {};
    final coordinates = centroid['coordinates'] ?? [0.0, 0.0];

    return Hospital(
      id: attributes['uuid'] ?? '',
      name: attributes['name'] ?? 'Unknown',
      latitude: (coordinates[1] as num).toDouble(),
      longitude: (coordinates[0] as num).toDouble(),
    );
  }
}


Future<List<Hospital>> fetchHospitals() async {
  const apiKey = '374b24636138b2bc626a2f23c1115de367e99777';
  const url = 'https://healthsites.io/api/v3/facilities/?api-key=$apiKey&page=1&country=Jamaica';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Hospital.fromJson(json)).toList();
  } else {
    print('Failed with status code: ${response.statusCode}');
    throw Exception('Failed to load hospitals');
  }
}



