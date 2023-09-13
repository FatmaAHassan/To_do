import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/shared/firebase/firebase_functions.dart';
import 'package:to_do/shared/styles/colors/app_colors.dart';

class EditTaskButtomSheet extends StatefulWidget {
  @override
  State<EditTaskButtomSheet> createState() => _EditTaskButtomSheetState();

  static const String routeName = 'edit';
}

class _EditTaskButtomSheetState extends State<EditTaskButtomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  "Edit Task",
                  style: GoogleFonts.elMessiri(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.blue.shade400),
                )),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value!.toString().length < 4) {
                  return 'please enter title at least 4 char';
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text('This is Title'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                label: Text('Task Description'),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
                width: double.infinity,
                child: Text(
                  'Select Date',
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            InkWell(
              onTap: () {
                chooseDateTime();
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    selectedDate.toString().substring(0, 10),
                    style: GoogleFonts.quicksand(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 18,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel task = TaskModel(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateUtils.dateOnly(selectedDate)
                          .millisecondsSinceEpoch,
                    );
                    //if firebase,disableNetwork only on your device
                    FirebaseFunctions.addTask(task);
                    Navigator.pop(context);
                    //if firebase.enableNetwork in main page
                    //   FirebaseFunctions.addTask(task).then((value){
                    //     Navigator.pop(context);
                    //   });
                  }
                },
                child: Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }

  void chooseDateTime() async {
    DateTime? chooseDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (chooseDate != null) {
      selectedDate = chooseDate;
      setState(() {});
    }
  }
}
