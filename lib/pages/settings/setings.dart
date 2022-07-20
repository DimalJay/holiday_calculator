import 'package:flutter/material.dart';

class SettingsItem {
  final Widget leading;
  final String title;
  final String subtitle;

  SettingsItem({
    required this.leading,
    required this.title,
    required this.subtitle,
  });
}

final settingsItems = <SettingsItem>[
  SettingsItem(
    leading: const Icon(Icons.light_mode_outlined),
    title: "App Theme",
    subtitle: "Light Theme",
  ),
  SettingsItem(
    leading: const Icon(Icons.language_rounded),
    title: "App Language",
    subtitle: "English",
  ),
  SettingsItem(
    leading: const Icon(Icons.location_city_rounded),
    title: "Country",
    subtitle: "Sri Lanka (LK)",
  ),
];

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListTile(title: Text("App Settings")),
            ...settingsItems.map((item) => _settingListTile(item)),
            const ListTile(title: Text("User Settings")),
            ExpansionTile(
              title: const Text("Weekend Holidays"),
              children: [
                ListTile(
                  leading: Checkbox(value: true, onChanged: (value) {}),
                  title: const Text("Mark Saturady is Your Holiday"),
                ),
                ListTile(
                  leading: Checkbox(value: true, onChanged: (value) {}),
                  title: const Text("Mark Sunday is Your Holiday"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  ListTile _settingListTile(SettingsItem settingsItem) {
    return ListTile(
      leading: settingsItem.leading,
      title: Text(settingsItem.title),
      subtitle: Text(settingsItem.subtitle),
    );
  }
}
