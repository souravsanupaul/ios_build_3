import 'package:flutter/material.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/common_widgets/rounded_button.dart';
import 'package:ott_code_frontend/common_widgets/rounded_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isEmail = true;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();

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
                Container(
                  width: media.width,
                  height: media.width * 0.5,
                  alignment: const Alignment(0, 0.5),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset(
                      "assets/images/app_logo.png",
                      width: media.width * 0.35,
                      height: media.width * 0.35,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: ApplicationColor.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Enter the email address or Phone number you used to\ncreate your account and we will email\nyou a link or send You an OTP to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ApplicationColor.subText,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundedTextField(
                  title: isEmail ? "Email" : "Mobile",
                  hintText: isEmail ? "Email here" : "Mobile here",
                  keyboardType: isEmail
                      ? TextInputType.emailAddress
                      : TextInputType.number,
                  controller: isEmail ? txtEmail : txtMobile,
                  right: TextButton(
                    onPressed: () {
                      // toggle email or mobile
                      setState(() {
                        isEmail = !isEmail;
                        if (isEmail) {
                          // Set to email mode
                          txtEmail.clear();
                          txtMobile.clear();
                        }
                      });
                    },
                    child: Icon(
                      isEmail
                          ? Icons.mobile_friendly_outlined
                          : Icons.email_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(onPressed: () {}, title: "Reset Password"),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
}
