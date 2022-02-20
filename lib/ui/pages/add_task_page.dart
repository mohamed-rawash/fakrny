import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fakrny/controllers/task_controller.dart';
import 'package:fakrny/ui/widgets/button.dart';
import 'package:fakrny/ui/widgets/input_field.dart';

import '../../models/task.dart';
import '../theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  String _selectedRepeat = 'None';
  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
            radius: 16,
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              const SizedBox(height: 20),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _noteController,
              ),
              const SizedBox(height: 20),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.date_range),
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  splashRadius: 24,
                  onPressed: () => _getDateFromUser(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time_rounded),
                        splashColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        splashRadius: 24,
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _endTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time_rounded),
                        splashColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        splashRadius: 24,
                        onPressed: () => _getTimeFromUser(isStartTime: false),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InputField(
                title: 'Remind',
                hint: '${_selectedRemind} minutes early',
                widget: Row(
                  children: [
                    DropdownButton(
                      items: remindList
                          .map(
                            (item) => DropdownMenuItem(
                              child: Text(
                                '$item',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              value: item,
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.keyboard_arrow_down_sharp,
                          color: Get.isDarkMode ? white : black),
                      iconSize: 24,
                      style: Theme.of(context).textTheme.headline5,
                      elevation: 8,
                      autofocus: false,
                      underline: Container(height: 0),
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: Get.isDarkMode ? orangeClr : cyan,
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedRemind = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: Row(
                  children: [
                    DropdownButton(
                      items: repeatList
                          .map(
                            (item) => DropdownMenuItem(
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              value: item,
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.keyboard_arrow_down_sharp,
                          color: Get.isDarkMode ? white : black),
                      iconSize: 24,
                      style: Theme.of(context).textTheme.headline5,
                      elevation: 8,
                      autofocus: false,
                      underline: Container(height: 0),
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: Get.isDarkMode ? orangeClr : cyan,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPalette(context),
                  MyButton(
                    label: 'Create Task',
                    onTap: () => _validateData(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasksToDb();
      _taskController.getTasks();
      Get.back();
    } else {
      _showSnackBar(title: "Warning", message: "All Fields Required!");
    }
  }

  _showSnackBar({required String title, required String message}) {
    return Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: _selectedColor == 0
          ? primaryClr.withOpacity(0.5)
          : _selectedColor == 1
              ? pinkClr.withOpacity(0.5)
              : orangeClr.withOpacity(0.5),
      colorText: Colors.black,
      icon: const Icon(
        Icons.warning_rounded,
        color: white,
        size: 24,
      ),
    );
  }

  _addTasksToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
      ),
    );
    print('$value *** *** ***');
  }

  Widget _colorPalette(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 5),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) => GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 24,
                          color: Colors.white,
                        )
                      : null,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickedTime = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (_pickedTime != null) {
      setState(() {
        _selectedDate = _pickedTime;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(
                const Duration(minutes: 15),
              ),
            ),
    );
    if(_pickedTime != null){
      setState(() {
        if(isStartTime){
          _startTime = _pickedTime.format(context);
        } else {
          _endTime = _pickedTime.format(context);
        }
      });
    }
  }
}
