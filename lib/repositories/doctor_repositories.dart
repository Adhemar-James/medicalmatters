import 'package:models/models.dart';

class DoctorRepository {
  const DoctorRepository();


  Future<List<DoctorCategory>> fetchDoctorCategories() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return DoctorCategory.values;
  }

  Future<List<Doctor>> fetchDoctors() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return Doctor.sampleDoctors;
  }

  Future<List<Doctor>> fetchDoctorsByCategory(int categoryId) async {
    throw UnimplementedError();
  }

  Future<Doctor> fetchDoctorById(int doctorId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return Doctor.sampleDoctors.firstWhere((doctor) => doctor.id == doctorId);
  }
}