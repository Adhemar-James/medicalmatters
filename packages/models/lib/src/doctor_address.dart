import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class DoctorAddress extends Equatable {
  final LatLng latLon;
  final String id;
  final String doctorId;
  final String streetAddress;
  final String streetNumber;
  final String city;
  final String parish;

  const DoctorAddress({
    required this.latLon,
    required this.id,
    required this.doctorId,
    required this.streetAddress,
    required this.streetNumber,
    required this.city,
    required this.parish,
  });

  DoctorAddress copyWith({
    LatLng? latLon,
    String? id,
    String? doctorId,
    String? streetAddress,
    String? streetNumber,
    String? city,
    String? parish,
  }) {
    return DoctorAddress(
      id: id ?? this.id,
      latLon: latLon ?? this.latLon,
      doctorId: doctorId ?? this.doctorId,
      streetAddress: streetAddress ?? this.streetAddress,
      streetNumber: streetNumber ?? this.streetNumber,
      city: city ?? this.city,
      parish: parish ?? this.parish,
    );
  }

  @override
  List<Object?> get props =>
      [
        id,
        latLon,
        doctorId,
        streetAddress,
        streetNumber,
        city,
        parish,
      ];

  static const sampleAddress = [
    DoctorAddress(
        latLon: LatLng(18.4714, 77.9229),
        id: '1',
        doctorId: '100',
        streetAddress: 'Dome Street',
        streetNumber: '999',
        city: 'Montego Bay',
        parish: 'St. James')
  ];

}
