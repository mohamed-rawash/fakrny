import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fakrny/controllers/task_controller.dart';
import 'package:fakrny/models/task.dart';
import 'package:fakrny/services/notification_services.dart';
import 'package:fakrny/services/theme_services.dart';
import 'package:fakrny/ui/theme.dart';
import 'package:fakrny/ui/widgets/task_tile.dart';

import '../size_config.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  late NotifyHelper notifyHelper;
  bool _isEmpty = false;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Get.isDarkMode
              ? const Icon(
                  Icons.wb_sunny_outlined,
                  color: Colors.white,
                  size: 30,
                )
              : const Icon(
                  Icons.nightlight_round_outlined,
                  color: Colors.black,
                  size: 30,
                ),
          splashRadius: 24,
          onPressed: () {
            ThemeServices().switchThemeMode();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_rounded, color: Colors.red, size: 30,),
            splashRadius: 32.0,
            onPressed: ()=> Get.defaultDialog(
              title: "Alert",
              titleStyle: TextStyle(
            color: Get.isDarkMode?Colors.white: Colors.black,
                fontSize: 18
            ),
              content: Text(
                  'Are You Sure To Delete All Tasks!',
                style: TextStyle(
                    color: Get.isDarkMode?Colors.white: Colors.black,
                    fontSize: 18
                ),
              ),
              cancel: ElevatedButton(
                child: Text(
                    'Cancel',
                  style: TextStyle(
                      color: Get.isDarkMode?Colors.white: Colors.black,
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () => Get.back(),
              ),
              confirm: ElevatedButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                      color: Get.isDarkMode?Colors.white: Colors.black,
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Get.isDarkMode? bluishClr: orangeClr,
                ),
                onPressed: () {
                  _taskController.deleteAllTasks();
                  notifyHelper.cancelAllNotification();
                  Get.back();
                  Get.snackbar(
                    'Confirming',
                    'Your Tasks Was Deleted Successfully',
                    duration: const Duration(seconds: 3),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Get.isDarkMode
                        ? primaryClr.withOpacity(0.6)
                        : orangeClr.withOpacity(0.6),
                    colorText: Get.isDarkMode?Colors.white: Colors.black,
                    icon: Icon(
                      Icons.cleaning_services_rounded,
                      color: Get.isDarkMode?Colors.white: Colors.black,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
            radius: 15,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _addTaskBar(),
              const SizedBox(height: 10),
              _addDateBar(),
              const SizedBox(height: 40),
              _showTasks(),
            ],
          ),
        ),
      ),
    );
  }

  _addTaskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              DateFormat.yMMMMd().format(DateTime.now()).toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.7,
          height: 45,
          child: ElevatedButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 24,
                  color: Get.isDarkMode ? white : black,
                ),
                Text(
                  'Add Task',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: Get.isDarkMode ? primaryClr : orangeClr,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () async {
              await Get.to(() => AddTaskPage());
            },
          ),
        ),
      ],
    );
  }

  _addDateBar() {
    return DatePicker(
      DateTime.now(),
      width: 60,
      height: 100,
      initialSelectedDate: DateTime.now(),
      selectionColor: Get.isDarkMode ? primaryClr : orangeClr,
      selectedTextColor: Get.isDarkMode ? white : black,
      monthTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: grey,
      ),
      dayTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: grey,
      ),
      dateTextStyle: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w700,
        color: grey,
      ),
      onDateChange: (newDate) {
        setState(() {
          _selectedDate = newDate;
        });
      },
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () => Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) =>
              _taskController.taskList.isNotEmpty,
          widgetBuilder: (BuildContext context) => RefreshIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            color: white,
            onRefresh: () => _taskController.getTasks(),
            child: ListView.separated(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _isEmpty ? 1 : _taskController.taskList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                Task task = _taskController.taskList[index];

                if (task.repeat == "Daily" ||
                    task.date == DateFormat.yMd().format(_selectedDate) ||
                    (task.repeat == 'Weekly' &&
                        _selectedDate
                                    .difference(
                                        DateFormat.yMd().parse(task.date!))
                                    .inDays %
                                7 ==
                            0) ||
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date!).day ==
                            _selectedDate.day)) {
                  var date = DateFormat.jm().parse(task.startTime!);
                  var notificationTime = DateFormat("HH:mm").format(date);

                  notifyHelper.scheduledNotification(
                    int.tryParse(notificationTime.toString().split(':')[0])!,
                    int.tryParse(notificationTime.toString().split(':')[1])!,
                    task,
                  );
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          child: TaskTile(task: task),
                          onTap: () => showBottomSheet(
                            context: context,
                            task: task,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          fallbackBuilder: (BuildContext context) => _emptyHomeMsg(
              message:
                  'You do not have any tasks yet!\nAdd new tasks to make your day easly,\nAnd do not miss any date.'),
        ),
      ),
    );
  }

  _emptyHomeMsg({required String message}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
          softWrap: true,
        ),
        Expanded(
          child: SvgPicture.asset(
            'assets/images/process.svg',
            //color: Get.isDarkMode? primaryClr : orangeClr,
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  showBottomSheet({required BuildContext context, required Task task}) {
    Get.bottomSheet(
      AnimationConfiguration.synchronized(
        duration: const Duration(milliseconds: 500),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 8),
              color: Get.isDarkMode ? darkHeaderClr : white,
              child: SlideAnimation(
                horizontalOffset: 600,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        height: 6,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Get.isDarkMode
                              ? Colors.grey[600]
                              : Colors.grey[30],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    task.isCompleted == 1
                        ? Container()
                        : _buildBottomSheet(
                            label: 'Task Completed',
                            onTap: () {
                              // FlutterLocalNotificationsPlugin.cancel(task.id);
                              _taskController.markTaskCompleted(
                                  task.id!, task.date!);
                              Get.back();
                            },
                            color: primaryClr.withOpacity(0.6),
                          ),
                    _buildBottomSheet(
                      label: 'Delete Task',
                      onTap: () {
                        notifyHelper.cancelNotification(id: task.id!);
                        _taskController.deleteTasks(task);
                        Get.back();
                      },
                      color: Colors.red.withOpacity(0.6),
                    ),
                    const SizedBox(height: 8),
                    Divider(
                      color: Get.isDarkMode ? white : darkGreyClr,
                      height: 2,
                      thickness: 2,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 8),
                    _buildBottomSheet(
                      label: 'Cancel',
                      onTap: () {
                        Get.back();
                      },
                      color: primaryClr,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color color,
    bool isClosed = false,
  }) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClosed
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : color),
          borderRadius: BorderRadius.circular(20),
          color: isClosed ? Colors.transparent : color,
        ),
        child: Text(
          label,
          style: isClosed
              ? Theme.of(context).textTheme.headline1
              : Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white),
        ),
      ),
      onTap: onTap,
    );
  }
}
