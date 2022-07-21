import 'package:flutter/material.dart';
import 'package:holyday_calculator/country_code.dart';
import 'package:holyday_calculator/domain/controller/cache_controller.dart';
import 'package:holyday_calculator/domain/models/country_model.dart';
import 'package:holyday_calculator/domain/providers/preference_provider.dart';
import 'package:provider/provider.dart';

class SettingsItem {
  final Widget leading;
  final Widget? traling;
  final String title;
  final String subtitle;
  final Function() onTap;

  SettingsItem({
    required this.leading,
    this.traling,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void themeSwitch() {
    final provider = Provider.of<PreferencesProvider>(context, listen: false);
    provider.darkMode = !provider.darkMode;
  }

  void openAppLanguageMenu(String language) {}
  void openUserCountryMenu(PreferencesProvider provider) {
    showDialog(
        context: context,
        builder: (context) {
          return userCountryWidget(provider);
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreferencesProvider>(context);
    List<SettingsItem> settingsItems = <SettingsItem>[
      SettingsItem(
        leading: themeIndicator(provider.darkMode),
        title: "App Theme",
        subtitle: provider.darkMode ? "Dark Theme" : "Light Theme",
        onTap: themeSwitch,
        traling: themeSwitchWidget(provider),
      ),
      SettingsItem(
        leading: const Icon(Icons.language_rounded),
        title: "App Language",
        subtitle: "English",
        onTap: () => openAppLanguageMenu(provider.appLanguage),
      ),
      SettingsItem(
        leading: const Icon(Icons.location_city_rounded),
        title: "Country",
        subtitle: _selectedCountry,
        onTap: () => openUserCountryMenu(provider),
      ),
    ];

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
                  leading: Checkbox(
                      value: provider.isSatIsHoliDay,
                      onChanged: (value) {
                        provider.isSatIsHoliDay = value ?? false;
                      }),
                  title: const Text("Mark Saturady is Your Holiday"),
                ),
                ListTile(
                  leading: Checkbox(
                      value: provider.isSunIsHoliDay,
                      onChanged: (value) {
                        provider.isSunIsHoliDay = value ?? false;
                      }),
                  title: const Text("Mark Sunday is Your Holiday"),
                )
              ],
            ),
            ListTile(
              title: const Text("Clear Cache"),
              leading: const Icon(Icons.cookie_rounded),
              onTap: clearCache,
            )
          ],
        ),
      ),
    );
  }

  void clearCache() {
    context.read<ApiCacheProvider>().clear();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Cache Cleared")));
  }

  Widget themeSwitchWidget(PreferencesProvider provider) {
    return Switch(
      value: provider.darkMode,
      onChanged: (value) => themeSwitch(),
    );
  }

  Widget themeIndicator(bool darkTheme) {
    if (darkTheme) {
      return const Icon(Icons.dark_mode, color: Colors.orange);
    } else {
      return const Icon(Icons.light_mode);
    }
  }

  Widget userCountryWidget(PreferencesProvider provider) {
    return AlertDialog(
      content: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Country country = countryCodes[index];
          return ListTile(
            trailing:
                provider.userCountry.toLowerCase() == country.code.toLowerCase()
                    ? const Icon(Icons.done)
                    : null,
            title: Text(country.name),
            onTap: () {
              provider.userCountry = country.code;
              Navigator.pop(context);
            },
          );
        },
        itemCount: countryCodes.length,
      ),
    );
  }

  String get _selectedCountry {
    final provider = Provider.of<PreferencesProvider>(context);
    return Country.fromCC(provider.userCountry).name;
  }

  ListTile _settingListTile(SettingsItem settingsItem) {
    return ListTile(
      leading: settingsItem.leading,
      trailing: settingsItem.traling,
      title: Text(settingsItem.title),
      subtitle: Text(settingsItem.subtitle),
      onTap: settingsItem.onTap,
    );
  }
}
