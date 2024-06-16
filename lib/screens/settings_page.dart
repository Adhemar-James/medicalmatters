import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[300],
    ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            BigUserCard(
              userName: 'Adhemar James',
              backgroundColor: Colors.blue,
              userProfilePic: const AssetImage('assets/onboarding/welcome_pic.png'),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                    withBackground: true,
                    borderRadius: 50,
                    backgroundColor: Colors.blue
                ),
                title: 'Profile',
                subtitle: 'Tap to change picture',
              ),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'Appearance',
                  subtitle: 'Do Stuff',
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.add,
                  iconStyle: IconStyle(
                    iconsColor: Colors.blue,
                    withBackground: true,
                    backgroundColor: Colors.grey[300],
                  ),
                  title: 'Test_1',
                  subtitle: 'Do Stuff Again!',
                  trailing:
                      Switch.adaptive(value: false, onChanged: (value) {}),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: 'Account',
                items: [
                  SettingsItem(
                    onTap: () {},
                      icons: Icons.logout,
                      title: 'Sign Out'
                  )
                ],
            ),
          ],
        ),
      ),
    );
  }
}
