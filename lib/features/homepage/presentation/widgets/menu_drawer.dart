import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list_drawer.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    super.key,
    required this.appcolor,
  });

  final Color appcolor;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  late SharedPreferences prefs;
  File? image;
  String? _imagepath;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  void saveImage(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", path);
  }

  void loadImage() async {
    SharedPreferences loadimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = loadimage.getString("imagepath");
    });
  }

  @override
  void initState() {
    super.initState();
    loadImage();
  }

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
            decoration: BoxDecoration(color: widget.appcolor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Welcome Boss!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                FloatingActionButton.large(
                    elevation: 0,
                    backgroundColor: Colors.greenAccent,
                    shape: const CircleBorder(),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            child: AlertDialog(
                              title: const Center(child: Text("Select")),
                              content: Row(
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.teal)),
                                        onPressed: () {
                                          pickImage(ImageSource.gallery);
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(Icons.image_outlined),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Text("Gallery"),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                      ),
                                      onPressed: () {
                                        pickImage(ImageSource.camera);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(Icons.camera_alt_outlined),
                                          SizedBox(
                                            width: 1,
                                          ),
                                          Text("Camera"),
                                        ],
                                      )),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      saveImage(image!.path);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok")),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: _imagepath != null
                        ? CircleAvatar(
                            radius: 45,
                            backgroundImage: FileImage(File(_imagepath!)),
                          )
                        : CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                image != null ? FileImage(image!) : null,
                          )),

                // CircleAvatar(
                //   radius: 25,
                //   backgroundImage: AssetImage("assets/birthday.jpg"),
                // ),
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
