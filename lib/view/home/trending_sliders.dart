import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ott_code_frontend/enviorment_var.dart';
import 'package:ott_code_frontend/view/home/movie_details_view.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider(
      {super.key, required this.media, required this.snapshot});

  final Size media;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: media.width,
      height: media.width * 0.5,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index, realIndex) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieDetailsView(
                            movie: snapshot.data[index],
                          )));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: media.width * 0.35,
                child: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    '${EnvironmentVars.imagePath}${snapshot.data[index].posterPath}'),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: media.width * 0.8,
          autoPlay: true,
          viewportFraction: 0.4,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 2),
        ),
      ),
    );
  }
}
