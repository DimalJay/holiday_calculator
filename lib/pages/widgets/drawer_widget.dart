import 'package:flutter/material.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  final data = <DraweItem>[
    DraweItem(
      title: "Settings",
      icon: Icons.settings_outlined,
      route: "/settings",
    ),
    DraweItem(
      title: "About Us",
      icon: Icons.info_outline_rounded,
      route: "/about_us",
    ),
    DraweItem(
      title: "Privacy Policy",
      icon: Icons.privacy_tip_outlined,
      route: "/privacy_policy",
    ),
    // DraweItem(
    //   title: "Support and Help",
    //   icon: Icons.contact_support_outlined,
    //   route: "/support",
    // ),
  ];

  final socialMedia = [
    SocialMediaButton(
      title: "Facebook",
      icon: Icons.facebook,
      uri: Uri.parse(facebookPage),
    ),
    SocialMediaButton(
      title: "Discord",
      icon: Icons.discord,
      uri: Uri.parse(discordServer),
    ),
    SocialMediaButton(
      title: "Email",
      icon: Icons.email_outlined,
      uri: Uri.parse(email),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: FlutterLogo(size: 60)),
          ...data.map((item) => _draweTile(context, item: item)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: socialMedia.map((e) => _socialMediaButton(e)).toList(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kPadding),
            child: Text(
              "Developed by TesKill Technologies\n© All Rights Reserved 2022",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Padding _socialMediaButton(SocialMediaButton button) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () async {
          await launchUrl(button.uri);
        },
        icon: Icon(
          button.icon,
          size: 28.0,
        ),
      ),
    );
  }

  ListTile _draweTile(BuildContext context, {required DraweItem item}) =>
      ListTile(
        leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: primaryColor.withOpacity(0.125)),
            child: Icon(
              item.icon,
              color: primaryColor.withOpacity(0.6),
            )),
        title: Text(item.title),
        onTap: () {
          Navigator.popAndPushNamed(context, item.route);
        },
      );
}

class DraweItem {
  final String title;
  final IconData icon;
  final String route;

  DraweItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class SocialMediaButton {
  final String title;
  final IconData icon;
  final Uri uri;

  SocialMediaButton({
    required this.title,
    required this.icon,
    required this.uri,
  });
}
