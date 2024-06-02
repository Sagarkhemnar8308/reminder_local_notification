import 'package:reminder/utility/utility_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Utility {
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;
  bool loading = false;

  void resetpassword() {
    _auth
        .sendPasswordResetEmail(email: emailcontroller.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });

      // SnackBarWidget.toastMessage(
      //     message:
      //         "We have sent a email to recovery your password , check email",
      //     textColor: white,
      //     backgroundColor: Colors.white);

      //context.pop();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      // SnackBarWidget.toastMessage(
      //     message: error.toString(), textColor: white, backgroundColor: Colors.white);
      //context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            heightBox10(),
            textFieldWidget(
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              controller: emailcontroller,
              textInputType: TextInputType.name,
              hintText: "Email ",
              borderRadius: 5,
              textColor: Colors.black,
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'please enter name';
                }
                return null;
              },
            ),
            heightBox10(),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFEDA75),
                    Color(0xFFFA7E1E),
                    Color(0xFFD62976),
                    Color(0xFF962FBF),
                    Color(0xFF4F5BD5)
                  ],
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: const BeveledRectangleBorder()),
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  resetpassword();
                },
                child: customTextWidget(
                  loading: loading,
                  text: 'Recover Password',
                  color: Colors.black,
                ),
              ),
            ),
            heightBox10(),
          ],
        ),
      ),
    );
  }
}
