import 'package:flutter/material.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/common_widgets/rounded_button.dart';
import 'package:ott_code_frontend/common_widgets/rounded_text_field.dart';
import 'package:ott_code_frontend/models/User.dart';
import 'package:ott_code_frontend/api/api.dart';
import 'package:ott_code_frontend/view/otp_panel/otp_container.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();

  // Validate email function
  bool _validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  // Validate name function
  bool _validateName(String value) {
    return value.isNotEmpty;
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showRegistrationCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ApplicationColor.bgColor, // Setting background color
          title: const Text('Registration Complete',
              style: TextStyle(color: Colors.white)), // Setting text color
          content: Container(
            decoration: BoxDecoration(
              color: Colors.black, // Setting background color
            ),
            child: const Text(
                'Your registration is complete. Please Verify Your OTP.',
                style: TextStyle(color: Colors.white)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OtpContainer(),
                  ),
                );
              },
              child:
                  const Text('Log In', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ApplicationColor.bgColor,
          title: const Text('Error',
              style: TextStyle(
                color: Colors.white,
              )),
          content: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(error, style: TextStyle(color: Colors.white)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _registerUser(BuildContext context) async {
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
      firstName: txtFirstName.text,
      lastName: txtLastName.text,
      password: txtPassword.text,
      phone: txtMobile.text,
      accountId: '0',
      lastLogin: '',
    );

    // Convert User object to JSON
    Map<String, dynamic> userData = user.toJson();

    try {
      var response = await Api().registerUserData(userData);
      Navigator.of(context).pop();
      _showRegistrationCompleteDialog(context);
    } catch (error) {
      Navigator.of(context).pop();
      _showErrorDialog(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/back_btn.png",
                  width: 13,
                  height: 13,
                  color: ApplicationColor.subText,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "BACK",
                  style: TextStyle(
                      color: ApplicationColor.subText,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: media.width * 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: ApplicationColor.cardDark,
                        borderRadius: BorderRadius.circular(media.width * 0.75),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 4))
                        ]),
                    child: Image.asset(
                      "assets/images/user_placeholder.png",
                      width: media.width * 0.18,
                      height: media.width * 0.18,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              RoundedTextField(
                  title: "First Name",
                  controller: txtFirstName,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              RoundedTextField(
                  title: "Last Name",
                  controller: txtLastName,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              RoundedTextField(
                  title: "Contact Number",
                  controller: txtMobile,
                  keyboardType: TextInputType.number),
              const SizedBox(
                height: 20,
              ),
              RoundedTextField(title: "Email Address", controller: txtEmail),
              const SizedBox(
                height: 20,
              ),
              RoundedTextField(
                title: "Password",
                obscureText: true,
                controller: txtPassword,
              ),
              const SizedBox(
                height: 20,
              ),
              RoundedButton(
                  onPressed: () {
                    if (!_validateName(txtFirstName.text)) {
                      _showSnackBar("First Name is required");
                      return;
                    }
                    if (!_validateName(txtLastName.text)) {
                      _showSnackBar("Last Name is required");
                      return;
                    }
                    if (!_validateEmail(txtEmail.text)) {
                      _showSnackBar("Email is required");
                      return;
                    }
                    _registerUser(context);
                  },
                  title: "Register"),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
