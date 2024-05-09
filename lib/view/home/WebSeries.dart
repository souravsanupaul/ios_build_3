import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/common_widgets/rounded_button.dart';
import 'package:ott_code_frontend/models/Episode.dart';
import 'package:ott_code_frontend/models/Song.dart';
import 'package:ott_code_frontend/view/home/CategoryDetailsView.dart';
import 'package:ott_code_frontend/view/home/EpisodeDetailsView.dart';
import 'package:ott_code_frontend/view/home/action_buttons.dart';

class WebSeries extends StatefulWidget {
  const WebSeries({super.key});

  @override
  State<WebSeries> createState() => _WebSeries();
}

class _WebSeries extends State<WebSeries> {
  List<List<Map<String, dynamic>>> seasons = [
    [
      {
        "name": "1. A Study in Pink",
        "image": "assets/images/ep_thum_1.png",
        "duration": "54 min",
        "id": "1001",
        "title":
            "Jamunar Teere _ Tribute to Prabha Atre _ Murshidabadi _ @RitamSen  _ Dyuti Mukherjee-(1080p)",
        "desc":
            "Vocal  Soumyadeep Sikdar (Murshidabadi) Lyric & Composition Ritam Sen , Dyuti Mukherjee Inspired by Jamuna Kinare by Prabha Atre  This is bengali transcreation of Prabha Atre's Jamuna Kinare. We sincerely tried to give a tribute to her magically soulful voice.  This music video was shot in Bolpur,in the winter of 2016.   Please do Like Share and Subscribe to share the spirit of Independent Music.",
        "image_16_9": "Jamunarteerebig(1).jpg",
        "encoded_file_path":
            "2/1712733434210-vihCYo6Od8lsEPJ9/1712733434210-vihCYo6Od8lsEPJ9-pl.m3u8",
        "imageUrl_thumbnail": "",
        "hlsFileId": "",
        "updatedAt": 0,
        "_id": "1234",
        "image_1_1": "",
        "image_9_16": "",
      },
      {
        "name": "2. The Blind Banker",
        "image": "assets/images/ep_thum_2.png",
        "duration": "55 min",
        "id": "1002",
        "title":
            "Mono Aji _ The Full Music Video _ ft. Lagnajita _ Murshidabadi _ Sagnik & Uma _ Neel _ Ritam",
        "desc":
            "Mono Aji takes its inspiration from Paimona Bideh Ki Khumaar Astam, a much loved kalaam by  Omar Khayyam, a Sufi poet and thinker (1048-1132 A.D.). It is not a translation of the original  song in Pashto/Dari language, rather an adaptation, an expression of the emotions it evokes.",
        "image_16_9": "monoaji1920x1080.jpg",
        "encoded_file_path":
            "2/1712733524950-MZqKH4oxFyNsZAA2/1712733524950-MZqKH4oxFyNsZAA2-pl.m3u8",
        "imageUrl_thumbnail": "",
        "hlsFileId": "",
        "updatedAt": 0,
        "_id": "123456",
        "image_1_1": "",
        "image_9_16": "",
      }
    ],
    [
      {
        "name": "1. A Scandal in Belgravia",
        "image": "assets/images/ep_thum_1.png",
        "duration": "54 min",
        "id": "1003",
        "title":
            "Susomoye Bhalobasha Hobe_Full Song _ Ritam Sen  _ Pucu _ Sarbik _ Kira _ Tapas",
        "desc":
            "Lyric and Direction - Ritam Sen Composition - Indradip Sarkar aka Pucu  Vocals - Sarbik Guha , Dyuti Mukherjee, Titas Bhromor Sen  Guitar - Hindol Mazumdar  Bass - Sudip Saha  Violin - Rajarshi Das  Cajon - Prestho  Recorded and Mixed by Abhibroto Mitra at Blooperhouse Studios",
        "image_16_9": "hridoyer_poster.jpg",
        "encoded_file_path":
            "2/1712734614473-KaE4zUklgCa9Yotw/1712734614473-KaE4zUklgCa9Yotw-pl.m3u8",
        "imageUrl_thumbnail": "",
        "hlsFileId": "",
        "updatedAt": 0,
        "_id": "1234222",
        "image_1_1": "",
        "image_9_16": "",
      },
      {
        "name": "2. The Hounds of Baskerville",
        "image": "assets/images/ep_thum_2.png",
        "duration": "55 min",
        "id": "1004",
        "title":
            "Ajo Take Mone Pore _ Taishi _ Shayan _ Hindol _ Pronoy _ Manidipa _ @RitamSen",
        "desc":
            "If you're feeling down and need to hear a happy song, then try out Aajo Take Mone Po( Lo-Fi Version) by Taishi Nandi , Written by Ritam Sen & Composed by Manidipa Singha . This song is sure to make you feel better and remind you that you're not alone in your struggles. Listen and enjoy!",
        "image_16_9": "big1.jpg",
        "encoded_file_path":
            "2/1712577821572-EEv2noMRAULqHtpF/1712577821572-EEv2noMRAULqHtpF-pl.m3u8",
        "imageUrl_thumbnail": "",
        "hlsFileId": "",
        "updatedAt": 0,
        "_id": "12234334",
        "image_1_1": "",
        "image_9_16": "",
      },
    ]
  ];

  @override
  void initState() {
    super.initState();
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
      body: Stack(
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
                        child: Image.asset(
                          "assets/images/tv_show.png",
                          width: media.width,
                          height: media.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: media.width,
                      height: media.width * 0.8,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            ApplicationColor.bgColor,
                            ApplicationColor.bgDark.withOpacity(0),
                            ApplicationColor.bgColor.withOpacity(0),
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
                        onTap: () {},
                        child: Image.asset("assets/images/play-button.png",
                            width: 55, height: 55),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sherlock",
                            style: TextStyle(
                                color: ApplicationColor.text,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Crime Film",
                                style: TextStyle(
                                    color: ApplicationColor.text,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    color: ApplicationColor.text,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Crime Fiction",
                                style: TextStyle(
                                    color: ApplicationColor.text,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "9.0",
                  style: TextStyle(
                    color: ApplicationColor.bgColor,
                    fontSize: 33,
                  ),
                ),
                IgnorePointer(
                  ignoring: true,
                  child: RatingBar(
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 18,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    ratingWidget: RatingWidget(
                      full: Image.asset("assets/images/star_fill.png"),
                      half: Image.asset("assets/images/star.png"),
                      empty: Image.asset("assets/images/star.png"),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "The quirky spin on Conan Doyle's iconic sleuth pitches him as a 'high-functioning sociopath' in modern-day London.",
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
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 25,
                ),
                DefaultTabController(
                  length: seasons.length,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TabBar(
                              isScrollable: true,
                              labelColor:
                                  Colors.white, // Set label color to white
                              unselectedLabelColor: Colors
                                  .white, // Set unselected label color to white
                              labelStyle: const TextStyle(
                                  fontWeight:
                                      FontWeight.bold), // Make text bold
                              tabs: List<Widget>.generate(
                                seasons.length,
                                (index) => Tab(
                                  text: 'Season ${index + 1}',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.6,
                        child: TabBarView(
                          children: List<Widget>.generate(
                            seasons.length,
                            (index) => _buildSeasonList(index),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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

  Widget _buildSeasonList(int index) {
    var season = seasons[index];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: season.asMap().entries.map((entry) {
          var episodeIndex = entry.key;
          var episode = entry.value;
          var image = episode["image"].toString();
          var song = Episode.fromJson(episode);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                _handleEpisodeClick(song);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: ApplicationColor.bgColor,
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.width * 0.25,
                        child: image != ""
                            ? ClipRect(
                                child: Image.asset(
                                  image,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${episodeIndex + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      episode["name"].toString(),
                      maxLines: 1,
                      style: TextStyle(
                        color: ApplicationColor.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    episode["duration"].toString(),
                    style: TextStyle(
                      color: ApplicationColor.subText,
                      fontSize: 13,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/tab_download.png",
                      width: 13,
                      height: 13,
                      color: ApplicationColor.primaryColor2,
                    ),
                    label: Text(
                      "Download",
                      style: TextStyle(
                        color: ApplicationColor.primaryColor2,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _handleEpisodeClick(Episode song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EpisodeDetailsView(categoryContent: song),
      ),
    );
  }
}
