import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/main.dart';
import 'package:reminder/reminder/addreminder.dart';
import 'package:reminder/reminder/deletereminder.dart';
import 'package:reminder/reminder/switcher.dart';
import 'package:reminder/services/notification_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool on = true;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    NotificationLogic.init(
      user?.uid ?? "",
    );
    localNotifications();
  }

  void localNotifications() {
    NotificationLogic.onNotification.listen((value) {});
  }

  void listenNotification() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("reminder app"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addReminder(
              context,
              user?.uid ?? "",
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(user?.uid ?? "")
              .collection('reminder')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == snapshot.hasError) {
              return const Center(
                child: Text("Error !"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No timer Added"),
              );
            }
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                Timestamp t = data?.docs[index].get('time');
                DateTime date = DateTime.fromMicrosecondsSinceEpoch(
                    t.microsecondsSinceEpoch);
                String formattedTime = DateFormat.jm().format(date);
                on = data!.docs[index].get('onOff');
                if (on) {
                  NotificationLogic.showNotifications(
                    datetime: date,
                    id: 0,
                    body: data.docs[index].get('body'),
                    title: data.docs[index].get('title'),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          child: ListTile(
                            subtitle: Text(formattedTime),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.docs[index].get('title')),
                                Text(data.docs[index].get('body'))
                              ],
                            ),
                            trailing: Wrap(
                              children: [
                                Switcher(data.docs[index].id, on,
                                    data.docs[index].get('time'), user!.uid),
                                IconButton(
                                  onPressed: () {
                                    deleteRemider(context, data.docs[index].id,
                                        user!.uid);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
