import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepTrackerScreen extends StatefulWidget {
  const StepTrackerScreen({super.key});

  @override
  _StepTrackerScreenState createState() => _StepTrackerScreenState();
}

class _StepTrackerScreenState extends State<StepTrackerScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  int _steps = 0;
  String _status = 'unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (await requestPermissions()) {
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(onStepCount).onError(onStepCountError);

      _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);
    } else {
      print('Permission denied');
    }
  }

  Future<bool> requestPermissions() async {
    var status = await Permission.activityRecognition.request();
    return status.isGranted;
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
    print('New step count: $_steps');
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
    print('New pedestrian status: $_status'); // Log pedestrian status
  }

  void onPedestrianStatusError(error) {
    print('Pedestrian Status Error: $error');
  }

  void onStepCountError(error) {
    print('Step Count Error: $error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Tracker'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(child: _buildStepCountCard()),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(child: _buildStatusCard()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepCountCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Steps Taken',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '$_steps',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Walking Status',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              _status,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
