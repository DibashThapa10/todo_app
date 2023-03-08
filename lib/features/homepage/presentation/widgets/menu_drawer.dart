import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'list_drawer.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
    required this.appcolor,
  });

  final Color appcolor;
  void exitApp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        SizedBox(
          height: 100,
          child: DrawerHeader(
            decoration: BoxDecoration(color: appcolor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Welcome Binaya!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/birthday.jpg"),
                ),
              ],
            ),
          ),
        ),
        DrawerList(
          icon: const Icon(Icons.person),
          text: 'Profile',
          ontap: () {},
        ),
        DrawerList(
          icon: const Icon(Icons.calendar_today_outlined),
          text: 'Start Date',
          ontap: () {},
        ),
        DrawerList(
          icon: const Icon(Icons.calendar_month_outlined),
          text: 'Due by',
          ontap: () {},
        ),
        DrawerList(
          icon: const Icon(Icons.access_alarm_outlined),
          text: 'Duration',
          ontap: () {},
        ),
        DrawerList(
          icon: const Icon(Icons.alarm_add_outlined),
          text: 'Reminder',
          ontap: () {},
        ),
        DrawerList(
          icon: const Icon(Icons.contact_page_outlined),
          text: 'Assigned to',
          ontap: () {},
        ),
        DrawerList(
          text: 'Exit',
          icon: const Icon(Icons.exit_to_app_outlined),
          ontap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Exit'),
                    content: const Text('Do you really want to exit the app?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            exitApp();
                          },
                          child: const Text('Yes'))
                    ],
                  );
                });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListTile(
            title: const Text(
              'Developed by Dibash Thapa',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 65, 135, 167)),
            ),
            onTap: () {},
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: ListTile(
            title: Text(
              'Best of Luck!',
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 65, 135, 167)),
            ),
          ),
        ),
      ]),
    );
  }
}
