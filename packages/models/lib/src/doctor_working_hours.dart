import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class DoctorWorkingHours extends Equatable {
  final String id;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String dayOfWeek;

  const DoctorWorkingHours({
      required this.id,
      required this.startTime,
      required this.endTime,
      required this.dayOfWeek
  });

  @override
  List<Object?> get props => [id, startTime, endTime, dayOfWeek];

  static List<DoctorWorkingHours> sampleDoctorWorkingHours = [
    const DoctorWorkingHours(
        id: '1',
        startTime: TimeOfDay(hour: 7, minute: 0),
        endTime: TimeOfDay(hour: 20, minute: 0),
        dayOfWeek: 'Monday',
    ),
    const DoctorWorkingHours(
      id: '2',
      startTime: TimeOfDay(hour: 7, minute: 0),
      endTime: TimeOfDay(hour: 20, minute: 0),
      dayOfWeek: 'Tuesday',
    ),
    const DoctorWorkingHours(
      id: '3',
      startTime: TimeOfDay(hour: 7, minute: 0),
      endTime: TimeOfDay(hour: 20, minute: 0),
      dayOfWeek: 'Wednesday',
    ),
    const DoctorWorkingHours(
      id: '4',
      startTime: TimeOfDay(hour: 7, minute: 0),
      endTime: TimeOfDay(hour: 20, minute: 0),
      dayOfWeek: 'Thursday',
    ),
    const DoctorWorkingHours(
      id: '5',
      startTime: TimeOfDay(hour: 7, minute: 0),
      endTime: TimeOfDay(hour: 20, minute: 0),
      dayOfWeek: 'Friday',
    ),
    const DoctorWorkingHours(
      id: '6',
      startTime: TimeOfDay(hour: 7, minute: 0),
      endTime: TimeOfDay(hour: 16, minute: 30),
      dayOfWeek: 'Saturday',
    ),
    const DoctorWorkingHours(
      id: '7',
      startTime: TimeOfDay(hour: 7, minute: 0),
      endTime: TimeOfDay(hour: 16, minute: 30),
      dayOfWeek: 'Sunday',
    ),
  ];
}