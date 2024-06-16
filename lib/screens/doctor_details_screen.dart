import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicalmatters/repositories/doctor_repositories.dart';
import 'package:medicalmatters/shared/utils/time_of_day_extension.dart';
import 'package:medicalmatters/state/doctor_details_bloc.dart';
import 'package:models/models.dart';
import '../widgets/cards/doctor_cards.dart';
import '../widgets/buttons/app_icon_button.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorDetailsBloc(
        doctorRepository: context.read<DoctorRepository>(),
      )..add(LoadDoctorDetailsEvent(doctorId: doctorId)),
      child: const DoctorDetailsView(),
    );
  }
}

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onTap: () => Navigator.pop(context),
        ),
        title: const Text(
          'Doctor Details',
        ),
        actions: [
          AppIconButton(icon: Icons.favorite_outline, onTap: () {}),
        ],
      ),
      body: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
        builder: (context, state) {
          if (state.status == DoctorDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == DoctorDetailsStatus.loaded) {
            final doctor = state.doctor;
            if (doctor == null) {
              return const Center(child: Text('Doctor not found'));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorCard(
                    doctor: doctor,
                    showAbout: true,
                    showMoreInformation: true,
                  ),
                  const Divider(height: 32),
                  _DoctorWorkingHours(workingHours: doctor.workingHours),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Failed to load doctor details'));
          }
        },
      ),
    );
  }
}

class _DoctorWorkingHours extends StatelessWidget {
  const _DoctorWorkingHours({
    required this.workingHours,
  });

  final List<DoctorWorkingHours> workingHours;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Working Hours',
        ),
        const SizedBox(height: 8),
        ListView.separated(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: workingHours.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final start = workingHours[index].startTime.toCustomString();
            final end = workingHours[index].endTime.toCustomString();
            return Row(
              children: [
                Expanded(
                  child: Text(workingHours[index].dayOfWeek),
                ),
                const SizedBox(width: 16),
                _WorkingHourText(text: start),
                const SizedBox(width: 16),
                const Text("-"),
                const SizedBox(width: 16),
                _WorkingHourText(text: end),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _WorkingHourText extends StatelessWidget {
  const _WorkingHourText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medicalmatters/repositories/doctor_repositories.dart';
// import 'package:medicalmatters/state/doctor_details_bloc.dart';
// import 'package:models/models.dart';
// import 'package:medicalmatters/shared/utils/time_of_day_extension.dart';
// import 'package:medicalmatters/widgets/buttons/app_icon_button.dart';
//
// import '../widgets/cards/doctor_cards.dart';
//
// class DoctorDetailsScreen extends StatelessWidget {
//   const DoctorDetailsScreen({super.key, required this.doctorId});
//
//   final String doctorId;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DoctorDetailsBloc(
//         doctorRepository: context.read<DoctorRepository>(),
//       )..add(LoadDoctorDetailsEvent(doctorId: doctorId)), // Corrected here
//       child: const DoctorDetailsView(),
//     );
//   }
// }
//
// class DoctorDetailsView extends StatelessWidget {
//   const DoctorDetailsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final colorScheme = Theme.of(context).colorScheme;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: AppIconButton(
//           icon: Icons.arrow_back,
//           onTap: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Doctor Details',
//           style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           AppIconButton(icon: Icons.favorite_outline, onTap: () {}),
//         ],
//       ),
//       body: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
//         builder: (context, state) {
//           if (state.status == DoctorDetailsStatus.initial ||
//               state.status == DoctorDetailsStatus.loading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state.status == DoctorDetailsStatus.loaded) {
//             final doctor = state.doctor;
//             if (doctor == null) {
//               return const Center(child: Text('Doctor not found'));
//             }
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DoctorCard(
//                     doctor: doctor,
//                     showAbout: true,
//                     showMoreInformation: true,
//                   ),
//                   Divider(height: 32, color: colorScheme.surfaceVariant),
//                   _DoctorWorkingHours(workingHours: doctor.workingHours),
//                 ],
//               ),
//             );
//           }
//           return const Center(child: Text('Failed to load doctor details'));
//         },
//       ),
//     );
//   }
// }
//
// class _DoctorWorkingHours extends StatelessWidget {
//   const _DoctorWorkingHours({
//     required this.workingHours,
//   });
//
//   final List<DoctorWorkingHours> workingHours;
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final colorScheme = Theme.of(context).colorScheme;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Working Hours',
//           style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         ListView.separated(
//           padding: const EdgeInsets.all(8),
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: workingHours.length,
//           separatorBuilder: (context, index) => const SizedBox(height: 8),
//           itemBuilder: (context, index) {
//             return Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     workingHours[index].dayOfWeek,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: colorScheme.surfaceVariant),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     workingHours[index].startTime.toCustomString(),
//                     style: textTheme.bodySmall!.copyWith(
//                       color: colorScheme.onBackground.withOpacity(.5),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 const Text("-"),
//                 const SizedBox(width: 16),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: colorScheme.surfaceVariant),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     workingHours[index].endTime.toCustomString(),
//                     style: textTheme.bodySmall!.copyWith(
//                       color: colorScheme.onBackground.withOpacity(.5),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
