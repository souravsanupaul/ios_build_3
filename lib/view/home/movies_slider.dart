import 'package:flutter/material.dart';
import 'package:ott_code_frontend/enviorment_var.dart';
import 'package:ott_code_frontend/view/home/movie_details_view.dart';

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({super.key, required this.media, required this.snapshot});

  final Size media;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: media.width,
      height: media.width * 0.6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailsView(
                              movie: snapshot.data[index],
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  width: media.width * 0.45,
                  child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${EnvironmentVars.imagePath}${snapshot.data![index].posterPath}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
