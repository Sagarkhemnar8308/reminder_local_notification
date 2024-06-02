import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reminder/auth/login.dart';
import 'package:reminder/homescreen.dart';
import 'package:reminder/utility/utility_mixin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Utility {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('Users');
  final _signinformkey = GlobalKey<FormState>();
  String profileUrl =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/510px-Default_pfp.svg.png";

  void signup() async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: emailcontroller.text.toString(),
        password: passwordcontroller.text.toString(),
      );

      String id = userCredential.user!.uid.toString();

      await firestore.doc(id).set({
        "id": id,
        "name": nameController.text.toString(),
        "email": emailcontroller.text.toString(),
        "mobilenumber": phonecontroller.text.toString(),
        "profileimage": profileUrl
      });

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    } catch (error) {
      print("error is $error");
      Fluttertoast.showToast(
        msg: error.toString(),
      );
      // SnackBarWidget.toastMessage(
      //   message: "Error: $error",
      //   backgroundColor: red,
      //   textColor: white,
      // );
    } finally {
      // Set loading state to false
      setState(() {
        loading = false;
      });
    }
  }

  signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String id = user.user!.uid.toString();
      await firestore.doc(id).set({
        "id": id,
        "name": user.user?.phoneNumber,
        "email": user.user?.email.toString(),
        "mobilenumber": user.user?.phoneNumber,
        "profileimage": user.user?.photoURL
      });

      log("Name is ${user.user?.displayName}");
      log("Email is ${user.user?.email}");
      log("Number is ${user.user?.phoneNumber}");
      log("Photourl is ${user.user?.photoURL}");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  signInWithFacebook() async {}

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _signinformkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ),
              heightBox10(),
              textFieldWidget(
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                borderRadius: 6,
                controller: nameController,
                textInputType: TextInputType.name,
                hintText: "Full name",
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
                controller: phonecontroller,
                textInputType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly
                ],
                hintText: "Mobile Number",
                textColor: Colors.white,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'please enter number';
                  }
                  if (value!.length < 10) {
                    return 'please enter 10 digit number';
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
                controller: emailcontroller,
                textInputType: TextInputType.emailAddress,
                hintText: "email ",
                textColor: Colors.white,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'please enter email';
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
                    return 'please enter password';
                  }
                  if (value!.length < 6) {
                    return 'enter password at least 6 digit password';
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
                      Color(0xFF4F5BD5),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: const BeveledRectangleBorder()),
                  onPressed: () async {
                    if (_signinformkey.currentState?.validate() ?? false) {
                      setState(() {
                        loading = true;
                      });
                      signup();
                    }
                  },
                  child: customTextWidget(
                    loading: loading,
                    text: 'Sign up',
                    color: Colors.black,
                  ),
                ),
              ),
              heightBox20(),
              InkWell(
                onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen(),));
                },
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account ? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: "Log in",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.red,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              heightBox10(),
              Center(
                child: customTextWidget(
                  text: 'Or',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              heightBox10(),
              InkWell(
                onTap: () {
                  signInWithGoogle();
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        12,
                      ),
                    ),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.g_mobiledata,
                        size: 40,
                        color: Colors.white,
                      ),
                      customTextWidget(
                        text: 'Sign In with Google',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //  InkWell(
              //   onTap: () {
              //     signInWithFacebook();
              //   },
              //   child: Container(
              //     height: 50.h,
              //     width: MediaQuery.of(context).size.width * 0.8,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(
              //           12.r,
              //         ),
              //       ),
              //       color: Colors.white,
              //       border: Border.all(
              //         color: white,
              //       ),
              //     ),
              //     alignment: Alignment.center,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.facebook,
              //           size: 40.sp,
              //           color: white,
              //         ),
              //         customTextWidget(
              //           text: 'Sign In with Facebook',
              //           style: TextStyle(
              //             color: white,
              //             fontSize: 14.sp,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
