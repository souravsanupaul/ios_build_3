import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ott_code_frontend/models/User.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/view/login/login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late String fullName = '';

  @override
  void initState() {
    super.initState();
    getUserFullName();
  }

  void getUserFullName() async {
    var box = await Hive.openBox<User>('userTable');
    var user = box.get('user');
    var firstName = user?.firstName ?? '';
    var lastName = user?.lastName ?? '';
    setState(() {
      fullName = '$firstName $lastName';
    });
  }

  List menuArr = [
    {
      "image": "assets/images/pr_user.png",
      "name": "Account",
    },
    {
      "image": "assets/images/pr_notification.png",
      "name": "Notification",
    },
    {
      "image": "assets/images/pr_settings.png",
      "name": "Setting",
    },
    {
      "image": "assets/images/pr_help.png",
      "name": "Help",
    },
    {
      "image": "assets/images/pr_logout.png",
      "name": "Logout",
    }
  ];

  void navigateToScreen(String name) {
    switch (name) {
      case "Account":
        // Navigate to Account screen
        break;
      case "Notification":
        // Navigate to Notification screen
        break;
      case "Setting":
        // Navigate to Setting screen
        break;
      case "Help":
        // Navigate to Help screen
        break;
      case "Logout":
        redirectToLogin();
        break;
      default:
        break;
    }
  }

  Future<void> redirectToLogin() async {
    var box = await Hive.openBox<User>('userTable');
    box.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ApplicationColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        //setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: ApplicationColor.primaryG,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius:
                                BorderRadius.circular(media.width * 0.20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 4))
                            ]),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: ApplicationColor.bgColor,
                              borderRadius:
                                  BorderRadius.circular(media.width * 0.15),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 4))
                              ]),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(media.width * 0.15),
                            child: Image.asset(
                              "assets/images/user_placeholder.png",
                              width: media.width * 0.28,
                              height: media.width * 0.28,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      fullName.isNotEmpty ? fullName : "User Name",
                      style: TextStyle(
                          color: ApplicationColor.subText,
                          fontSize: 27,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Premium User",
                      style: TextStyle(
                        color: ApplicationColor.primaryColor2,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var mObj = menuArr[index] as Map? ?? {};
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          child: InkWell(
                            onTap: () {
                              navigateToScreen(mObj["name"].toString());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  mObj["image"].toString(),
                                  width: 20,
                                  height: 20,
                                  color: ApplicationColor.text,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  mObj["name"].toString(),
                                  style: TextStyle(
                                    color: ApplicationColor.text,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                    separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: ApplicationColor.subText.withOpacity(0.2),
                        ),
                    itemCount: menuArr.length)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
