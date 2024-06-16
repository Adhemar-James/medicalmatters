import 'package:flutter/material.dart';

enum ConsultationMode{
  video(
    label: 'Video',
    description: 'Online Video Call',
    icon: Icons.video_call,
  ),
  audio(
    label: 'Audio',
    description: 'Online Audio Call',
    icon: Icons.voice_chat,
  ),
  chat(
    label: 'Chat',
    description: 'Online Chat (via WhatsApp)',
    icon: Icons.message,
  ),
  inPerson(
    label: 'In-Person',
    description: 'Meet A Doctor in Person',
    icon: Icons.people,
  );

  final String label;
  final String description;
  final IconData icon;

  const ConsultationMode ({
    required this.label,
    required this.description,
    required this.icon,
});
}