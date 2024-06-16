import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../main.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
              color: Colors.blue.shade100,
              urlImage: 'assets/onboarding/welcome_pic.png',
              title: 'Your Health, Our Priority',
              subtitle: 'We help you manage your health and wellness',
            ),
            buildPage(
              color: Colors.blue.shade200,
              urlImage: 'assets/onboarding/medical_2.jpeg',
              title: 'Expert Doctors',
              subtitle: 'Connect with the best doctors around you',
            ),
            buildPage(
              color: Colors.blue.shade300,
              urlImage: 'assets/onboarding/login_2.jpeg',
              title: 'Easy Appointments',
              subtitle: 'Schedule appointments with ease',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.blue,
          minimumSize: const Size.fromHeight(80),
        ),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()), // Update this line
          );
        },
        child: const Text(
          'Get Started',
          style: TextStyle(fontSize: 24),
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => controller.jumpToPage(2),
              child: const Text('SKIP'),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const WormEffect(
                  activeDotColor: Colors.blue,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
            TextButton(
              onPressed: () => controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
              child: const Text('NEXT'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   urlImage,
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            // ),
            const SizedBox(height: 64),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}
