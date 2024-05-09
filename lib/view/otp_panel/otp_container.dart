import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ott_code_frontend/Utility.dart';
import 'package:ott_code_frontend/api/api.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/common_widgets/rounded_button.dart';
import 'package:ott_code_frontend/common_widgets/rounded_text_field.dart';
import 'package:ott_code_frontend/models/User.dart';
import 'package:ott_code_frontend/view/main_tab/main_tab_bar_view.dart';
import 'package:telephony/telephony.dart';

class OtpContainer extends StatefulWidget {
  const OtpContainer({super.key});

  @override
  State<OtpContainer> createState() => _OtpContainerState();
}

class _OtpContainerState extends State<OtpContainer> {
  final Telephony telephony = Telephony.instance;
  TextEditingController txtOtp = TextEditingController();

  String textRecieved = "";

  void startListening() {
    print("Listing to sms.");
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          String otpCode = message.body!.substring(0, 6);
          setState(() {
            txtOtp.text = otpCode;
            //wait for 2 sec and then press _validateOtp submit
            Future.delayed(Duration(seconds: 3), () {
              _validateOtp(context);
            });
          });
        },
        listenInBackground: false);
  }

  @override
  void initState() {
    startListening();
    super.initState();
    // txtOtp = TextEditingController(text: '1234');
  }

  bool _validateForm() {
    if (txtOtp.text.isEmpty) {
      _showSnackBar("Please enter a valid OTP");
      return false;
    }
    return true;
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  void _validateOtp(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // Retrieve user data from Hive
    var box = await Hive.openBox<User>('userTable');
    var user = box.get('user');
    var accountId = user?.accountId;
    var emailId = user?.email;

    if (_validateForm()) {
      Map<String, dynamic> otpVerificationData = {
        'user_id': accountId,
        'otp': txtOtp.text,
        'action': 'login',
        'device_id': '1231313',
        'remember_me': true,
      };

      print("Payload ==> $otpVerificationData");

      try {
        var response = await Api().otpVerfify(otpVerificationData);
        var responseBody = response.body;
        var jsonData = jsonDecode(responseBody);
        if (jsonData["error_code"] == 0) {
          var resResult = jsonData["result"];
          var name = resResult["name"];
          var token = resResult["token"];

          var firstName = "";
          var lastName = "";

          if (name != null && name.isNotEmpty) {
            List<String> nameParts = name.split(" ");
            firstName = nameParts[0];
            if (nameParts.length > 1) {
              lastName = nameParts.sublist(1).join(" ");
            }
          }

          var userNew = new User(
              accountId: accountId,
              userToken: token,
              firstName: firstName,
              lastName: lastName,
              email: emailId,
              lastLogin: Utility.getTimestamp().toString());

          Navigator.of(context).pop();
          await box.put('user', userNew);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainTabBarView(),
            ),
          );
        } else {
          Navigator.of(context).pop();
          _showErrorDialog(context, jsonData["message"]);
        }
      } catch (error) {
        if (kDebugMode) {
          print("Error: $error");
        }
        Navigator.of(context).pop();
        _showErrorDialog(context, "Error Occured Please try again");
      }
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
                  "Validate OTP",
                  style: TextStyle(
                      color: ApplicationColor.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Please enter the One-Time Password (OTP) sent to your email address or phone number to validate your account.",
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
                  title: "Enter OTP",
                  controller: txtOtp,
                  right: TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.pin,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                    onPressed: () {
                      _validateOtp(context);
                    },
                    title: "Validate OTP"),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
}
