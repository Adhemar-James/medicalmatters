import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicalmatters/screens/onboarding_screen.dart';
import 'package:medicalmatters/state/home_bloc.dart';
import 'package:medicalmatters/widgets/avatars/circle_avatar_with_text.dart';
import 'package:medicalmatters/widgets/titles/section_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/utils/hospital_data.dart';
import '../widgets/botton_nav_bar/main_nav_bar.dart';
import '../widgets/cards/appointment_preview_card.dart';
import '../widgets/list_tiles/doctor_list_tile.dart';
import 'google_maps_handler.dart'; // Import the Google Maps handler file
import 'package:firebase_auth/firebase_auth.dart';

import 'messaging_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? firstName = FirebaseAuth.instance.currentUser?.displayName;

    return HomeView(firstName: firstName);
  }
}

class HomeView extends StatefulWidget {
  final String? firstName;

  const HomeView({super.key, this.firstName});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Colors.grey[300],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.firstName ?? 'User',
              style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                  fontSize: 24),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                final hospitalLocation = Hospital(
                  id: 'Test',
                  name: 'Select Hospital',
                  latitude: 18.4704,
                  longitude: -77.91,
                );
                GoogleMapsHandler.openGoogleMaps(context, hospitalLocation);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: colorScheme.secondary,
                  ),
                  Text(
                    'Location',
                    style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.red),
                  ),
                  // const SizedBox(width: 0.5),
                  const Icon(
                    Icons.expand_more,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessagingScreen()),
              );
            },
            icon: Icon(
              Icons.notifications_none_rounded,
              color: colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: toggleTheme,
            icon: Icon(
              isDarkMode ? CupertinoIcons.sun_max : CupertinoIcons.moon,
              color: colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', false);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const OnboardingPage()));
            },
            icon: Icon(
              Icons.logout,
              color: colorScheme.primary,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Doctors...',
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.grey,
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.filter_alt_outlined,
                        color: colorScheme.surfaceContainerHighest),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading ||
              state.status == HomeStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == HomeStatus.loaded) {
            return const SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _DoctorCategories(),
                  SizedBox(height: 24),
                  _MySchedule(),
                  SizedBox(height: 24),
                  _NearbyDoctors(),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Failed to load'),
            );
          }
        },
      ),
      bottomNavigationBar: const MainNavBar(),
      backgroundColor: isDarkMode ? Colors.white : Colors.grey[300],
    );
  }
}


class _NearbyDoctors extends StatelessWidget {
  const _NearbyDoctors();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitle(
              title: 'Nearby Doctors',
              action: 'See All',
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return Divider(
                  height: 24.0,
                  color: colorScheme.surfaceContainerHighest,
                );
              },
              itemCount: state.nearbyDoctors.length,
              itemBuilder: (context, index) {
                final doctor = state.nearbyDoctors[index];
                return DoctorListTile(doctor: doctor);
              },
            ),
          ],
        );
      },
    );
  }
}

class _MySchedule extends StatelessWidget {
  const _MySchedule();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'My Schedule',
          action: 'See All',
          onPressed: () {},
        ),
        const AppointmentPreviewCard(),
      ],
    );
  }
}

class _DoctorCategories extends StatelessWidget {
  const _DoctorCategories();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitle(
              title: 'Categories',
              action: 'See All',
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: state.doctorCategories
                  .take(5)
                  .map((category) => Expanded(
                child: CircleAvatarWithTextLabel(
                    icon: category.icon, label: category.name),
              ))
                  .toList(),
            )
          ],
        );
      },
    );
  }
}
