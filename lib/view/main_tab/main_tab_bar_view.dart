import 'package:flutter/material.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/view/download/download_view.dart';
import 'package:ott_code_frontend/view/home/WatchListView.dart';
import 'package:ott_code_frontend/view/home/home_view.dart';
import 'package:ott_code_frontend/view/profile/profile_view.dart';
import 'package:ott_code_frontend/view/search/search_view.dart';

class MainTabBarView extends StatefulWidget {
  const MainTabBarView({Key? key}) : super(key: key);

  @override
  State<MainTabBarView> createState() => _MainTabBarViewState();
}

class _MainTabBarViewState extends State<MainTabBarView>
    with TickerProviderStateMixin {
  late TabController tabController;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    // 5 tabs => Home, Search, Download, Profile, WatchList
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      selectedTab = tabController.index;
      if (mounted) {
        setState(() {});
      }
    });

    FBroadcast.instance().register("change_mode", (value, callback) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: const [
          HomeView(),
          SearchView(),
          DownloadView(),
          ProfileView(),
          WatchListView(),
        ],
      ),

      // floating start
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: ApplicationColor.primaryColor,
      //   onPressed: () {
      //     ApplicationColor.themeModeDark = !ApplicationColor.themeModeDark;
      //     FBroadcast.instance().broadcast("change_mode");
      //     if (mounted) {
      //       setState(() {});
      //     }
      //   },
      //   child: Icon(
      //     ApplicationColor.themeModeDark ? Icons.light_mode : Icons.dark_mode,
      //     color: ApplicationColor.text,
      //   ),
      // ),

      // floating end

      backgroundColor: ApplicationColor.bgColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ApplicationColor.bgColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
            indicatorWeight: 0.1,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
                return Colors.transparent;
              },
            ),
            labelStyle: TextStyle(
              color: ApplicationColor.subText,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: TextStyle(
              color: ApplicationColor.primaryColor2,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelColor: ApplicationColor.subText,
            labelColor: ApplicationColor.primaryColor,
            controller: tabController,
            // Adjust the padding here to decrease the margin between tabs
            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
            indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
            tabs: const [
              Tab(
                text: "Home",
                icon: Icon(Icons.home),
              ),
              Tab(
                text: "Search",
                icon: Icon(Icons.search),
              ),
              Tab(
                text: "Download",
                icon: Icon(Icons.file_download),
              ),
              Tab(
                text: "Profile",
                icon: Icon(Icons.person),
              ),
              Tab(
                text: "WatchList",
                icon: Icon(Icons.playlist_add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
