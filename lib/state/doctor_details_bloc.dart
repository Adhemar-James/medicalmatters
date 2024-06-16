import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicalmatters/repositories/doctor_repositories.dart';
import 'package:models/models.dart';

part 'doctor_details_event.dart';
part 'doctor_details_state.dart';

class DoctorDetailsBloc extends Bloc<DoctorDetailsEvent, DoctorDetailsState> {
  final DoctorRepository _doctorRepository;

  DoctorDetailsBloc({
    required DoctorRepository doctorRepository,
  })  : _doctorRepository = doctorRepository,
        super(const DoctorDetailsState()) {
    on<LoadDoctorDetailsEvent>(_onLoadDoctorDetailsEvent);
  }

  void _onLoadDoctorDetailsEvent(
      LoadDoctorDetailsEvent event,
      Emitter<DoctorDetailsState> emit,
      ) async {
    emit(state.copyWith(status: DoctorDetailsStatus.loading));
    try {
      final doctor = await _doctorRepository.fetchDoctorById(int.parse(event.doctorId));

      emit(state.copyWith(
        status: DoctorDetailsStatus.loaded,
        doctor: doctor,
      ));
        } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(status: DoctorDetailsStatus.error));
    }
  }
}
