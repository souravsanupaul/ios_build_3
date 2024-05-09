import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ott_code_frontend/models/OTTModel.dart';
import 'package:ott_code_frontend/models/User.dart';
import 'package:ott_code_frontend/view/home/company_list_widget.dart';
import 'package:ott_code_frontend/view/login/login_view.dart';
import 'package:hive/hive.dart';
import 'package:ott_code_frontend/view/main_tab/main_tab_bar_view.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(OTTModelAdapter());
  runApp(const MyApp());
}

// Future<void> clearHiveData() async {
//   final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
//   final hiveDirectory = appDocumentDir.path + '/hive';
//   final hiveDirectoryExists = await Directory(hiveDirectory).exists();
//   if (hiveDirectoryExists) {
//     await Directory(hiveDirectory).delete(recursive: true);
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    // });

    super.initState();
    // userAccountCheck();
  }

  // void userAccountCheck() async {
  //   var box = await Hive.openBox<User>('userTable');
  //   var user = box.get('user');
  //   var accountId = user?.accountId ?? '';

  //   if (accountId != '') {
  //     print("Account ID ==> $accountId");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const MainTabBarView(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OTT App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Gotham",
        useMaterial3: true,
      ),
      home: const MainTabBarView(),
    );
  }
}
