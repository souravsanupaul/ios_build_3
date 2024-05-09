import 'package:carousel_slider/carousel_slider.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:ott_code_frontend/api/api.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/models/Categories.dart';
import 'package:ott_code_frontend/view/home/Category_slider.dart';
import 'package:ott_code_frontend/view/home/WebSeries.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Categories>> categories;
  int selectedNavItem = 0;

  @override
  void initState() {
    super.initState();
    categories = Api().getCategories(searchString: '');

    FBroadcast.instance().register("change_mode", (value, callback) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                FutureBuilder(
                  future: categories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final categoriesWithSongs = snapshot.data!
                          .where((category) => category.songs.isNotEmpty)
                          .toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          for (int i = 0; i < categoriesWithSongs.length; i++)
                            CategorySlider(
                              category: categoriesWithSongs[i],
                              media: media,
                              index: i, // Pass the index to CategorySlider
                            ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(
                    height:
                        10), // Add some space between the FutureBuilder and the Text widget
                const Text(
                  "Web series",
                  style: TextStyle(
                    fontFamily: "Gotham",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Navigate to another widget when the image is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WebSeries()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerLeft, // Align image to the left
                    width: 200, // Adjust width as needed
                    height: 200, // Adjust height as needed
                    child: Image.asset(
                      'assets/images/tv_show.png',
                      fit:
                          BoxFit.cover, // Ensure the image covers the container
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Fixed navigation items
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent, // Adjust color as needed
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNavItem('All', 0),
                  buildNavItem('Special', 1),
                  buildNavItem('Emotional', 2),
                  buildNavItem('Traditional', 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(String title, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedNavItem = index;
        });
        // Handle click event for each navigation item here
        switch (index) {
          case 0:
            // Handle All click event
            break;
          case 1:
            // Handle Special click event
            break;
          case 2:
            // Handle Emotional click event
            break;
          case 3:
            // Handle Traditional click event
            break;
          default:
            break;
        }
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          decoration: selectedNavItem == index
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationColor: Colors.red,
          decorationThickness: 5.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
