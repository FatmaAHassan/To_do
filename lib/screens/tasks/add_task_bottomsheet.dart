import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/shared/firebase/firebase_functions.dart';
import 'package:to_do/shared/styles/colors/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  // const AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheet();
}

class _AddTaskBottomSheet extends State<AddTaskBottomSheet> {
  var formkey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add New Task",
              style: GoogleFonts.elMessiri(
                color: Colors.blue.shade400,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value!.toString().length < 4) {
                    return "Please enter title at least 4 char";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text(
                      "Task Title ",
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: primaryColor))),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            TextFormField(
              maxLines: 4,
              controller: descriptionController,
              decoration: InputDecoration(
                  label: Text("Task Description "),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: primaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: primaryColor))),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
                width: double.infinity,
                child: Text(
                  "Select Date ",
                  style: GoogleFonts.quicksand(
                      fontSize: 18,
                      color: primaryColor,
                      fontWeight: FontWeight.w500),
                )),
            InkWell(
              onTap: () {
                ChooseDateTime();
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    selectedDate.toString().substring(0, 10),
                    style: GoogleFonts.aBeeZee(fontSize: 14),
                  )),
            ),
            SizedBox(
              height: 18,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    TaskModel task = TaskModel(
                        description: descriptionController.text,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        title: titleController.text,
                        date: DateUtils.dateOnly(selectedDate)
                            .millisecondsSinceEpoch);
                    FirebaseFunctions.addTask(task);

                    Navigator.pop(context);
                  }
                },
                child: Text(
                  " Add Task ",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  void ChooseDateTime() async {
    DateTime? chooseDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (chooseDate != null) {
      selectedDate = chooseDate;
      setState(() {});
    }
  }
}
