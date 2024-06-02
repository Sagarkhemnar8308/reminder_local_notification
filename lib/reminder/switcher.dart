import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder/model/reminder_model.dart';

// ignore: must_be_immutable
class Switcher extends StatefulWidget {
  bool onOff;
  String uid;
  Timestamp timestamp;
  String id;

  Switcher(this.id, this.onOff, this.timestamp, this.uid, {super.key});

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  late bool _onOff;

  @override
  void initState() {
    super.initState();
    _onOff = widget.onOff;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _onOff,
      onChanged: (value) async {
        setState(() {
          _onOff = value;
        });
        ReminderModel r1 = ReminderModel();
        r1.onOff=value;
        r1.timestamp=widget.timestamp;
        r1.id= widget.id;
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.uid)
            .collection('reminder')
            .doc(widget.id)
            .update({'onOff':_onOff, 'id':widget.id});
      },
    );
  }
}

