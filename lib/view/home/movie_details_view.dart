import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ott_code_frontend/api/api.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/common_widgets/rounded_button.dart';
import 'package:ott_code_frontend/enviorment_var.dart';
import 'package:ott_code_frontend/models/Casts.dart';
import 'package:ott_code_frontend/models/Movie.dart';
import 'package:ott_code_frontend/view/home/casts_slider.dart';
import 'package:ott_code_frontend/view/home/genres.dart';
import 'package:ott_code_frontend/view/home/movie_player.dart';

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({super.key, required this.movie});
  final Movie movie;

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  late Movie _movie;
  late Future<List<Casts>> movieCasts;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _movie = widget.movie;
    movieCasts = Api().getMovieCasts(_movie.id);

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
      backgroundColor: ApplicationColor.bgColor,
      body: _isPlaying
          ? MoviePlayer(
              videoUrl: "",
              videoText: "",
            )
          : Stack(
              alignment: Alignment.topCenter,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            width: media.width,
                            height: media.width * 0.8,
                            child: ClipRect(
                              child: Image.network(
                                '${EnvironmentVars.imagePath}${_movie.posterPath}',
                                width: media.width,
                                height: media.width,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                          Container(
                            width: media.width,
                            height: media.width * 0.8,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  ApplicationColor.bgDark,
                                  ApplicationColor.bgDark.withOpacity(0),
                                  ApplicationColor.bgDark.withOpacity(0),
                                  ApplicationColor.bgColor
                                ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                          ),
                          Container(
                            width: media.width,
                            height: media.width * 0.8,
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                //TODO Play
                                setState(() {
                                  _isPlaying = true;
                                });
                              },
                              child: Image.asset(
                                  "assets/images/play-button.png",
                                  width: 55,
                                  height: 55),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _movie.title,
                                  style: TextStyle(
                                      color: ApplicationColor.text,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Genres(),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        _movie.voteAverage.toStringAsFixed(1),
                        style: TextStyle(
                          color: ApplicationColor.text,
                          fontSize: 33,
                        ),
                      ),
                      IgnorePointer(
                        ignoring: true,
                        child: RatingBar(
                          initialRating: _movie.voteAverage / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 18,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          ratingWidget: RatingWidget(
                            full: Image.asset("assets/images/star_fill.png"),
                            half: Image.asset("assets/images/star.png"),
                            empty: Image.asset("assets/images/star.png"),
                          ),
                          onRatingUpdate: (rating) {
                            //print(rating);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          _movie.overView,
                          style: TextStyle(
                            color: ApplicationColor.text,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 150,
                        child: RoundedButton(
                          title: "WATCH NOW",
                          height: 40,
                          onPressed: () {
                            setState(() {
                              _isPlaying = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Cast",
                                style: TextStyle(
                                    color: ApplicationColor.text,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                            ]),
                      ),
                      SizedBox(
                        child: FutureBuilder(
                          future: movieCasts,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text("Some error occured"),
                              );
                            } else if (snapshot.hasData) {
                              return CastsSliders(
                                media: media,
                                snapshot: snapshot,
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      AppBar(
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
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "BACK",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
