import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/res/app_colors.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/core/common/widgets/white_space.dart';

class TaskTile extends StatelessWidget {
  final TaskModel? task;
  const TaskTile({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGColor(task?.color ?? 0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task?.title ?? "",
                    style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const WhiteSpace(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const WhiteSpace(
                        width: 4,
                      ),
                      Text(
                        "${task?.startTime} - ${task?.endTime}",
                        style: GoogleFonts.acme(
                          textStyle:
                              TextStyle(fontSize: 13, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                  const WhiteSpace(
                    height: 12,
                  ),
                  Text(
                    task?.note ?? "",
                    style: GoogleFonts.acme(
                      textStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task?.isCompleted == 1 ? 'COMPLETED' : 'TODO',
                style: GoogleFonts.acme(
                  textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getBGColor(int no) {
    switch (no) {
      case 0:
        return AppColors.bluish;
      case 1:
        return AppColors.pink;
      case 2:
        return AppColors.yellow;
      default:
        return AppColors.bluish;
    }
  }
}
