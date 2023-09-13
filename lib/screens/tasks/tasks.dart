import 'package:calendar_timeline/src/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do/screens/tasks/task_item.dart';
import 'package:to_do/shared/firebase/firebase_functions.dart';
import 'package:to_do/shared/styles/colors/app_colors.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  // const TasksTab({super.key});
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          // initialDate: DateTime.now(),
          // firstDate: DateTime.now().add(Duration(days: 365)),
          // lastDate: DateTime(2100, 11, 20),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {});
          },
          leftMargin: 20,
          monthColor: primaryColor,
          dayColor: primaryColor.withOpacity(.6),
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primaryColor,
          dotsColor: primaryColor,
          selectableDayPredicate: (date) => date.day != 5,
          locale: 'en',
        ),
        StreamBuilder(
          stream: FirebaseFunctions.getTasks(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("Sorry Something Went Wrong");
            }
            var tasks = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

            if (tasks.isEmpty) {
              return Center(child: Text("No Tasks"));
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: tasks[index],
                  );
                },
                itemCount: tasks.length,
              ),
            );
          },
        )
      ],
    );
  }
}
