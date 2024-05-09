import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/enviorment_var.dart';
import 'package:ott_code_frontend/models/Categories.dart';
import 'package:ott_code_frontend/view/home/CategoryDetailsView.dart';

class CategorySlider extends StatelessWidget {
  const CategorySlider({
    Key? key,
    required this.category,
    required this.media,
    required this.index,
  }) : super(key: key);

  final Categories category;
  final Size media;
  final int index;

  @override
  Widget build(BuildContext context) {
    double firstCarouselHeight = 0.3;
    double aspectRatio = media.aspectRatio;
    bool isIndexThree = index == 3;

    double heightForIndexThree =
        media.height * 0.3; // Decreased height for index 3
    double marginBetweenSliders = 8.0; // Decreased margin between sliders

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index != 0) // Show category title only if index is not 0
          Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              // bottom: index == 1 || index == 2 || index == 4 ? 0.0 : 16.0,
              // top: index == 1 || index == 2 || index == 4 ? 8.0 : 16.0,
            ),
            child: Text(
              category.title,
              style: TextStyle(
                fontFamily: "Gotham",
                fontWeight: FontWeight.w700,
                color: ApplicationColor.text,
                fontSize: 25,
              ),
            ),
          ),
        SizedBox(
          width: media.width,
          height: isIndexThree
              ? heightForIndexThree
              : index == 0
                  ? media.height * firstCarouselHeight
                  : media.width * 0.3, // Adjusted height for index != 0
          child: Container(
            margin: EdgeInsets.only(
                bottom:
                    marginBetweenSliders), // Adjusted margin between sliders
            child: CarouselSlider.builder(
              itemCount: category.songs.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryDetailsView(
                          categoryContent: category.songs[index],
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '${EnvironmentVars.bucketUrl}/${category.songs[index].imageUrl_poster}',
                      fit: isIndexThree
                          ? BoxFit.cover
                          : aspectRatio > 1
                              ? BoxFit.fitHeight // Landscape
                              : BoxFit.fitWidth, // Portrait
                      width: media.width,
                      height: isIndexThree
                          ? heightForIndexThree
                          : index == 0
                              ? media.height * firstCarouselHeight
                              : media.width *
                                  0.4, // Adjusted height for index != 0
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: isIndexThree
                    ? heightForIndexThree
                    : index == 0
                        ? media.height * firstCarouselHeight
                        : media.width * 0.4, // Adjusted height for index != 0
                autoPlay: index != 0,
                initialPage: 0, // Ensure carousel starts from the beginning
                viewportFraction: index == 0 ? 1.0 : 0.4,
                enlargeCenterPage: true,
                pageSnapping: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(seconds: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
