import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:task_management/services/theme_services.dart';
import 'package:task_management/services/notification_services.dart';
import 'package:task_management/core/common/widgets/white_space.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var notificationService;

  @override
  void initState() {
    super.initState();
    NotificationServices.initializeNotification();
    // notificationService = NotificationServices();
    // notificationService.initializeNotification();
    // notificationService.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: Column(
          children: [
            Text(
              "Welcome Hnin Hnin",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          // notificationService.displayNotification(
          //   title: 'Theme Changed',
          //   body: Get.isDarkMode
          //       ? "Activated Light Theme"
          //       : "Activated Dark Theme",
          // );
          NotificationServices.showInstanceNotification(
              "Theme Changed",
              Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activated Dark Theme");
          NotificationServices.showScheduledNotification();

          // notificationService.scheduledNotification();
        },
        child: Icon(
          Icons.nightlight_round,
          size: 20,
        ),
      ),
      actions: [
        Icon(
          Icons.person,
          size: 20,
        ),
        WhiteSpace(
          width: 20,
        )
      ],
    );
  }
}
