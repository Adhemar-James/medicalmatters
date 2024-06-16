import 'package:appearance/appearance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:medicalmatters/firebase/firebase_api.dart';
import 'package:medicalmatters/repositories/doctor_repositories.dart';
import 'package:medicalmatters/screens/booking.dart';
import 'package:medicalmatters/screens/explore_screen.dart';
import 'package:medicalmatters/screens/google_maps_handler.dart';
import 'package:medicalmatters/screens/home_screen.dart';
import 'package:medicalmatters/screens/login_page.dart';
import 'package:medicalmatters/screens/settings_page.dart';
import 'package:medicalmatters/screens/step_tracker.dart';
import 'package:medicalmatters/screens/register_page.dart';
import 'package:medicalmatters/shared/app_theme.dart';
import 'package:medicalmatters/state/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesManager.instance.init();
  await FirebaseApi().initNotifications();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  const doctorRepository = DoctorRepository();
  runApp(MyApp(doctorRepository: doctorRepository, showHome: showHome));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.doctorRepository,
    required this.showHome,
  });

  final DoctorRepository doctorRepository;
  final bool showHome;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: doctorRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(doctorRepository: doctorRepository)
              ..add(LoadHomeEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: const AppTheme().themeData,
          home: showHome ? const HomeScreen() : const LoginOrRegisterPage(),
          routes: {
            '/explore': (context) => const ExploreScreen(),
            '/steps': (context) => const StepTrackerScreen(),
            '/register': (context) => RegisterPage(showLoginPage: () => Navigator.pop(context)),
            '/maps': (context) => const YourGoogleMapsScreen(),
            '/profile': (context) => const SettingsPage(),
            '/booking': (context) => const BookingScreen()
          },
        ),
      ),
    );
  }
}

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? LoginPage(showRegisterPage: togglePages)
        : RegisterPage(showLoginPage: togglePages);
  }
}
