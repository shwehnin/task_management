import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../../core/res/app_colors.dart';
import '../../../core/common/widgets/white_space.dart';
import 'package:task_management/core/res/text_style.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/core/common/widgets/custom_button.dart';
import 'package:task_management/core/common/widgets/custom_input_field.dart';
import 'package:task_management/features/task/controllers/task_controller.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly"];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: CustomText.headingStyle,
              ),
              CustomInputField(
                title: 'Title',
                hint: "Enter your title",
                controller: _titleController,
              ),
              CustomInputField(
                title: 'Note',
                hint: "Enter your note",
                controller: _noteController,
              ),
              CustomInputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInputField(
                      title: "Start Date",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const WhiteSpace(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomInputField(
                      title: "End Date",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              CustomInputField(
                title: "Remind",
                hint: "$_selectedRemind minues early",
                widget: DropdownButton(
                  items: remindList.map((int value) {
                    return DropdownMenuItem(
                      value: value.toString(),
                      child: Text(
                        value.toString(),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                  iconSize: 32,
                  elevation: 4,
                  style: CustomText.subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
              ),
              CustomInputField(
                title: "Repeat",
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                    elevation: 4,
                    style: CustomText.subTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    items: repeatList.map((e) {
                      return DropdownMenuItem(
                          value: e.toString(), child: Text(e.toString()));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRepeat = value.toString();
                      });
                    }),
              ),
              const WhiteSpace(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallete(),
                  CustomButton(
                      color: AppColors.bluish,
                      width: 100,
                      height: 60,
                      label: "Create Task",
                      onTap: () {
                        _validateData();
                      })
                ],
              )
            ],
          ),
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
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new,
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(2121),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("It is null or something went wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context).trim();
    if (pickedTime == null) {
      print("Time Cancel");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    // int hour = int.parse(_startTime.split(":")[0]);
    // int minute = int.parse(_startTime.split(":")[1].split(" ")[0]);
    List<String> timeParts = _startTime.trim().split(" ");
    int hour = int.parse(timeParts[0].split(":")[0]);
    int minute = int.parse(timeParts[0].split(":")[1]);
    return showTimePicker(
      // initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: CustomText.titleStyle,
        ),
        const WhiteSpace(
          height: 10,
        ),
        Wrap(
          children: List.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 20),
                child: CircleAvatar(
                  backgroundColor: index == 0
                      ? AppColors.bluish
                      : index == 1
                          ? AppColors.pink
                          : AppColors.yellow,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: AppColors.white,
                          size: 20,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else {
      Get.snackbar("Required", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.white,
          colorText: AppColors.pink,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.pink,
          ));
    }
  }

  _addTaskToDB() async {
    var id = await _taskController.addTask(
      task: TaskModel(
        title: _titleController.text.trim(),
        note: _noteController.text.trim(),
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    print("Id id $id");
  }
}
