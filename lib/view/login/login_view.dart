import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ott_code_frontend/api/api.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/common_widgets/rounded_button.dart';
import 'package:ott_code_frontend/common_widgets/rounded_text_field.dart';
import 'package:ott_code_frontend/models/User.dart';
import 'package:ott_code_frontend/view/forgot_password/forgot_password_view.dart';
import 'package:ott_code_frontend/view/otp_panel/otp_container.dart';
import 'package:ott_code_frontend/view/registration/registration_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtMobile = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _validateForm() {
    if (txtEmail.text.isEmpty) {
      _showSnackBar("Please enter your email or contact number");
      return false;
    }

    if (txtPassword.text.isEmpty) {
      _showSnackBar("Please enter your password");
      return false;
    }

    return true;
  }

  void _loginUser(BuildContext context) async {
    if (_validateForm()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      User user = User(
        email: txtEmail.text,
        password: txtPassword.text,
      );

      // Convert User object to JSON
      Map<String, dynamic> userData = user.toJson();

      try {
        var response = await Api().loginUserData(userData);
        var responseBody = response.body;
        var jsonData = jsonDecode(responseBody);
        if (jsonData["error_code"] == 0) {
          if (kDebugMode) {
            print("Json data after click login ===>  $jsonData");
          }
          var user = User(
            email: txtEmail.text,
            accountId: jsonData["user_id"],
          );
          // Open Hive box and store User model
          var box = await Hive.openBox<User>('userTable');
          await box.put('user', user);
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OtpContainer(),
            ),
          );
        }
      } catch (error) {
        if (kDebugMode) {
          print("Error: $error");
        }
        Navigator.of(context).pop();
      }
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ApplicationColor.bgColor,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: ApplicationColor.primaryColor,
      //   onPressed: () {
      //     ApplicationColor.themeModeDark = !ApplicationColor.themeModeDark;
      //     if (mounted) {
      //       setState(() {});
      //     }
      //   },
      //   child: Icon(
      //     ApplicationColor.themeModeDark ? Icons.light_mode : Icons.dark_mode,
      //     color: ApplicationColor.text,
      //   ),
      // ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            width: media.width,
            height: media.width,
            child: ClipRect(
              child: Transform.scale(
                  scale: 1.3,
                  child: Image.asset(
                    "assets/images/login_top.png",
                    width: media.width,
                    height: media.width,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Container(
            width: media.width,
            height: media.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                ApplicationColor.bgColor.withOpacity(0),
                ApplicationColor.bgColor.withOpacity(0),
                ApplicationColor.bgColor
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: media.width,
                    height: media.width * 0.75,
                    alignment: const Alignment(0, 0.5),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: ApplicationColor.themeModeDark
                              ? Colors.transparent
                              : ApplicationColor.bgColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: ApplicationColor.themeModeDark
                              ? null
                              : const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 4))
                                ]),
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: media.width * 0.5,
                        height: media.width * 0.5,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  RoundedTextField(
                    title: "Email",
                    keyboardType: TextInputType.emailAddress,
                    controller: txtEmail,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedTextField(
                    title: "Password",
                    obscureText: true,
                    controller: txtPassword,
                    right: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: Text(
                        "Forgot ?",
                        style: TextStyle(
                            color: ApplicationColor.text,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                      onPressed: () {
                        _loginUser(context);
                      },
                      title: "Log In"),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: ApplicationColor.subText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Social Logins",
                          style: TextStyle(
                              color: ApplicationColor.subText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: ApplicationColor.subText,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/images/fb_btn.png",
                          width: 45,
                          height: 45,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/images/google_btn.png",
                          width: 45,
                          height: 45,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Don't have an account?",
                      style: TextStyle(
                          color: ApplicationColor.subText,
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                  TextButton(
                    onPressed: () {
                      // redirect register
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationView()));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: ApplicationColor.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
