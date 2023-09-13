import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/screens/tasks/edit_task_button.dart';
import 'package:to_do/shared/firebase/firebase_functions.dart';
import 'package:to_do/shared/styles/colors/app_colors.dart';

class TaskItem extends StatefulWidget {
  TaskModel taskModel;

  TaskItem({required this.taskModel, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Slidable(
        startActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(widget.taskModel.id);
            },
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              showEditTaskBottomSheet();
            },
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ]),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                height: 80,
                color: primaryColor,
                width: 4,
              ),
              SizedBox(
                width: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.taskModel.title,
                    style: GoogleFonts.quicksand(fontSize: 18),
                  ),
                  Text(
                    widget.taskModel.description,
                    style: GoogleFonts.quicksand(fontSize: 14),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  widget.taskModel.isDone = !widget.taskModel.isDone;
                  FirebaseFunctions.updateTask(widget.taskModel);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                    color:
                        widget.taskModel.isDone ? Colors.green : primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showEditTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(18), topLeft: Radius.circular(18)),
      ),
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EditTaskButtomSheet(),
      ),
    );
  }
}
