import 'package:models/models.dart';
import 'package:equatable/equatable.dart';

import 'doctor_package.dart';

class Doctor extends Equatable {
  final String id;
  final String name;
  final String bio;
  final String profileImageUrl;
  final DoctorCategory doctorCategory;
  final doctorAddress;
  final List<DoctorPackage> packages;
  final List<DoctorWorkingHours> workingHours;
  final double rating;
  final int reviewCount;
  final int patientCount;

  const Doctor({
    required this.id,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
    required this.doctorCategory,
    required this.doctorAddress,
    required this.packages,
    required this.workingHours,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.patientCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        bio,
        profileImageUrl,
        doctorCategory,
        doctorAddress,
        packages,
        workingHours,
        rating,
        reviewCount,
        patientCount,
      ];

  static final sampleDoctors = [
    Doctor(
      id: '1',
      name: 'Dr. Akiko Yosano',
      bio: 'Saiyan raised on Earth',
      profileImageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
      doctorCategory: DoctorCategory.dermatology,
      doctorAddress: DoctorAddress.sampleAddress,
      packages: DoctorPackage.samplePackages,
      workingHours: DoctorWorkingHours.sampleDoctorWorkingHours,
      rating: 4.5,
      reviewCount: 74,
      patientCount: 100,
    ),
    Doctor(
      id: '2',
      name: 'Dr. Ratio',
      bio: 'Saiyan raised in Space',
      profileImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeIAYQ5f0oNFayyI8WKDUh7wkfTgxCXrHSxQ&s',
      doctorCategory: DoctorCategory.dentist,
      doctorAddress: DoctorAddress.sampleAddress,
      packages: DoctorPackage.samplePackages,
      workingHours: DoctorWorkingHours.sampleDoctorWorkingHours,
      rating: 4.5,
      reviewCount: 99,
      patientCount: 130,
    ),
  ];
}
