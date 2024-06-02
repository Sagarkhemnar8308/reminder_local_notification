import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

deleteRemider(BuildContext context, String id, String uid) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Reminder'),
        content: const Text('are you sure you want to delete ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('cancel'),
          ),
          TextButton(
            onPressed: () {
              try {
                FirebaseFirestore.instance.collection('Users').doc(uid).collection('reminder').doc(id).delete();
                 Fluttertoast.showToast(
                  msg: "Reminder Delete",
                );
                Navigator.pop(context);
              } catch (e) {
                Fluttertoast.showToast(
                  msg: e.toString(),
                );
              }
            },
            child: const Text('delete'),
          )
        ],
      );
    },
  );
}
