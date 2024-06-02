import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderModel {
  String? id;
  Timestamp? timestamp;
  bool? onOff;
  String? title;
  String? body;

  ReminderModel({
    this.timestamp,
    this.onOff,
    this.id,
    this.body,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'time': timestamp,
      'onOff': onOff,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory ReminderModel.fromMap(map) {
    return ReminderModel(
        timestamp: map['time'],
        onOff: map['onOff'],
        id: map['id'],
        body: map['body'],
        title: map['title']);
  }
}
