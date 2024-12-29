import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/res/app_colors.dart';
import 'package:task_management/core/res/text_style.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/services/theme_services.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:task_management/services/notification_services.dart';
import 'package:task_management/core/common/widgets/white_space.dart';
import 'package:task_management/features/task/views/add_task_page.dart';
import 'package:task_management/core/common/widgets/custom_button.dart';
import 'package:task_management/features/task/views/widgets/task_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:task_management/features/task/controllers/task_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

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
            const WhiteSpace(
              height: 10,
            ),
            _showTasks(),
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
          // NotificationServices.showScheduledNotification();
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
              color: AppColors.bluish,
              label: "+ Add Task",
              width: 100,
              height: 60,
              onTap: () async {
                await Get.to(() => const AddTaskPage());
                _taskController.getTasks();
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
        dateTextStyle: GoogleFonts.acme(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.lightGray,
          ),
        ),
        dayTextStyle: GoogleFonts.acme(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.lightGray,
          ),
        ),
        monthTextStyle: GoogleFonts.acme(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.lightGray,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (context, index) {
            TaskModel task = _taskController.taskList[index];
            print("Task Data ${task.toJson()}");
            if (task.repeat == 'Daily') {
              var startTime = task.startTime;
              print("Start Time is $startTime");

              // Trim the string to avoid hidden characters
              String trimmedStartTime = startTime.toString().trim();
              print("Trimmed Start Time: $trimmedStartTime");

              try {
                // Use the custom format "h:mm a" instead of jm
                DateTime date = DateFormat("h:mm a")
                    .parse(trimmedStartTime); // 12-hour format with AM/PM
                String myTime =
                    DateFormat("HH:mm").format(date); // 24-hour format

                NotificationServices.showScheduledNotification(
                  int.parse(myTime.split(":")[0]),
                  int.parse(myTime.split(":")[1]),
                  task,
                );
              } catch (e) {
                print("Error parsing time: $e");
              }
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showModalBottomSheet(context, task);
                        },
                        child: TaskTile(
                          task: task,
                        ),
                      )
                    ],
                  )));
            }
            if (task.date == DateFormat.yMd().format(_selectedDate)) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showModalBottomSheet(context, task);
                        },
                        child: TaskTile(
                          task: task,
                        ),
                      )
                    ],
                  )));
            } else {
              return Container();
            }
          });
    }));
  }

  _showModalBottomSheet(BuildContext context, TaskModel task) {
    Get.bottomSheet(Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 4, left: 20, right: 20, bottom: 10),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * .24
          : MediaQuery.of(context).size.height * .32,
      color: Get.isDarkMode ? AppColors.darkBackground : AppColors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : CustomButton(
                  label: 'Task Completed',
                  onTap: () {
                    _taskController.makeTaskCompleted(task.id!);
                    Get.back();
                  },
                  height: 50,
                  color: AppColors.primaryColor,
                ),
          const WhiteSpace(
            height: 12,
          ),
          CustomButton(
            label: 'Delete Task',
            onTap: () {
              _taskController.delete(task);
              Get.back();
            },
            height: 50,
            color: AppColors.pink,
          ),
          const WhiteSpace(
            height: 20,
          ),
          CustomButton(
            isClose: true,
            label: 'Close',
            onTap: () {
              Get.back();
            },
            height: 50,
            color: AppColors.pink,
          ),
        ],
      ),
    ));
  }
}
