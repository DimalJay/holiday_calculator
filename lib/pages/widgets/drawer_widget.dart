import 'package:flutter/material.dart';
import 'package:holyday_calculator/constraints/values.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  final data = <DraweItem>[
    DraweItem(
      title: "Settings",
      icon: Icons.settings_outlined,
      widget: const SizedBox(),
    ),
    DraweItem(
      title: "About Us",
      icon: Icons.info_outline_rounded,
      widget: const SizedBox(),
    ),
    DraweItem(
      title: "Privacy Policy",
      icon: Icons.privacy_tip_outlined,
      widget: const SizedBox(),
    ),
    DraweItem(
      title: "Terms & Conditions",
      icon: Icons.text_snippet_outlined,
      widget: const SizedBox(),
    ),
    DraweItem(
      title: "Contact Us",
      icon: Icons.call,
      widget: const SizedBox(),
    ),
    DraweItem(
      title: "Support and Help",
      icon: Icons.contact_support_outlined,
      widget: const SizedBox(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: FlutterLogo(size: 60)),
          ...data.map((e) => _draweTile(e)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.facebook,
                    size: 28.0,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.reddit,
                    size: 28.0,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.email_outlined,
                    size: 28.0,
                    color: Colors.black87,
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
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

  ListTile _draweTile(DraweItem draweItem) => ListTile(
        leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: primaryColor.withOpacity(0.125)),
            child: Icon(
              draweItem.icon,
              color: primaryColor.withOpacity(0.6),
            )),
        title: Text(draweItem.title),
      );
}

class DraweItem {
  final String title;
  final IconData icon;
  final Widget widget;

  DraweItem({
    required this.title,
    required this.icon,
    required this.widget,
  });
}
