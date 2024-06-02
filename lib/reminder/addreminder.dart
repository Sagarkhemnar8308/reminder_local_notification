import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reminder/model/reminder_model.dart';

addReminder(BuildContext context, String uid) {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController bodycontroller = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  add(String uid, TimeOfDay time) {
    try {
      DateTime d = DateTime.now();
      DateTime dateTime =
          DateTime(d.year, d.month, d.day, time.hour, time.minute);
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      ReminderModel reminderModel = ReminderModel();
      reminderModel.timestamp = timestamp;
      reminderModel.onOff = true;
      reminderModel.body=bodycontroller.text.toString();
      reminderModel.title=titlecontroller.text.toString();
      reminderModel.id=d.microsecondsSinceEpoch.toString();
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('reminder')
          .doc()
          .set(reminderModel.toMap());
      Fluttertoast.showToast(msg: 'Reminder added Successfully ');
      Navigator.pop(context);
    } catch (e, stk) {
      Fluttertoast.showToast(msg: 'Message $e $stk');
    }
  }

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                25,
              ),
            ),
            title: const Text('Add Reminder'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Select a time for Reminder"),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: TextFormField(
                      controller: titlecontroller,
                      decoration: const InputDecoration(
                          hintText: "title", border: OutlineInputBorder()),
                    ),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: TextFormField(
                      controller: bodycontroller,
                      decoration: const InputDecoration(
                          hintText: "body", border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (newTime == null) return;
                      setState(() {
                        time = newTime;
                      });
                    },
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.clock,
                          color: Colors.green,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          time.format(context),
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (newTime == null) return;
                        setState(() {
                          time = newTime;
                        });
                      },
                      child: const Text("Select Time"))
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    add(uid, time);
                  },
                  child: const Text('Add'))
            ],
          );
        },
      );
    },
  );
}
