import 'package:flutter/material.dart';
import 'package:fakrny/models/task.dart';
import 'package:fakrny/ui/size_config.dart';
import 'package:fakrny/ui/theme.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 2
            : SizeConfig.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task.color),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        task.title!,
                        style: Theme.of(context).textTheme.headline1,
                        overflow: TextOverflow.ellipsis,
                        textDirection: ui.TextDirection.rtl,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey.withOpacity(.6),
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${task.startTime} - ${task.endTime}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        task.note!,
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 2,
                  height: 70,
                  color: Colors.grey[200]!.withOpacity(0.7),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    task.isCompleted == 0? 'TODO':'Completed',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch(color){
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}
