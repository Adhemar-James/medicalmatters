import 'package:intl/intl.dart'; // Import this for formatting duration

enum ConsultationMode {
  video,
  audio,
  chat,
  inPerson,
}

class DoctorPackage {
  final String id;
  final String doctorId;
  final String packageName;
  final String description;
  final Duration duration;
  final int price;
  final String consultationMode;

  DoctorPackage({
    required this.id,
    required this.doctorId,
    required this.packageName,
    required this.description,
    required this.duration,
    required this.price,
    required this.consultationMode,
  });

  static List<DoctorPackage> samplePackages = [
    DoctorPackage(
      id: '1',
      doctorId: '100',
      packageName: 'Basic',
      description: 'Simple Stuff',
      duration: const Duration(minutes: 40),
      price: 100,
      consultationMode: ConsultationMode.video.toString(),
    )
  ];

  // Helper method to display duration as a formatted string
  String getFormattedDuration() {
    final Duration dur = duration;
    return dur.inHours > 0
        ? '${dur.inHours}h ${dur.inMinutes.remainder(60)}m'
        : '${dur.inMinutes}m';
  }

  // Helper method to display price as a formatted string
  String getFormattedPrice() {
    final NumberFormat formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return formatter.format(price);
  }
}
