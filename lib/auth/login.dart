import 'package:reminder/homescreen.dart';
import 'package:reminder/utility/utility_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> with Utility {
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool loading = false;

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      // SnackBarWidget.toastMessage(
      //   message: "Login Successfully",
      //   backgroundColor:green,
      //   textColor: Colors.black,
      // );
      //context.push(Routes.dashboard);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      // SnackBarWidget.toastMessage(
      //     message: error.toString(),
      //     backgroundColor: red,
      //     textColor: Colors.black);
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    print("arrow login---------------------->   ${user?.uid}");
    return Scaffold(
      backgroundColor:Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            heightBox10(),
            textFieldWidget(
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              borderRadius: 6,
              controller: emailcontroller,
              textInputType: TextInputType.name,
              hintText: "email ",
              textColor: Colors.white,
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'please enter name';
                }
                return null;
              },
            ),
            heightBox10(),
            textFieldWidget(
              borderRadius: 6,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              controller: passwordcontroller,
              textInputType: TextInputType.name,
              hintText: "password ",
              textColor: Colors.white,
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'please enter name';
                }
                return null;
              },
            ),
            heightBox10(),
            InkWell(
              onTap: () {
            
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: customTextWidget(
                  text: 'Forget password ?  ',
                  color: Colors.red,
                ),
              ),
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
                    Color(0xFF4F5BD5),
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
                  login();
                },
                child: customTextWidget(
                    loading: loading, text: 'Log in', color: Colors.black,),
              ),
            ),
            heightBox10(),
            InkWell(
              onTap: () {
                //context.push(Routes.signup);
              },
              child: Center(
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Don't  have an account ? ",
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                  TextSpan(
                    text: "sign up",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.red,
                        fontSize: 14),
                  )
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
