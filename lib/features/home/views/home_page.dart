import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/res/app_colors.dart';
import 'package:task_management/core/res/text_style.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:task_management/services/theme_services.dart';
import 'package:task_management/services/notification_services.dart';
import 'package:task_management/core/common/widgets/white_space.dart';
import 'package:task_management/features/task/views/add_task_page.dart';
import 'package:task_management/core/common/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    NotificationServices.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          NotificationServices.showInstanceNotification(
              "Theme Changed",
              Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activated Dark Theme");
          NotificationServices.showScheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? AppColors.white : AppColors.darkBackground,
        ),
      ),
      actions: const [
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

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: CustomText.subHeadingStyle,
              ),
              Text(
                "Today",
                style: CustomText.headingStyle,
              ),
            ],
          ),
          CustomButton(
              label: "+ Add Task",
              onTap: () {
                Get.to(AddTaskPage());
              })
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: AppColors.primaryColor,
        selectedTextColor: AppColors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.lightGray,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.lightGray,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.lightGray,
          ),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }
}
