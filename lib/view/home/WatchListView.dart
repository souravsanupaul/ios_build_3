import 'package:flutter/material.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/models/Episode.dart';
import 'package:ott_code_frontend/view/home/EpisodeDetailsView.dart'; // Import the Episode class

// Define a model class for WatchList movie items
class WatchListItem {
  final String name;
  final String image;
  final String duration;
  final String id;
  final String title;
  final String desc;
  final String image169;
  final String encodedFilePath;
  final String imageUrlThumbnail;
  final String hlsFileId;
  final int updatedAt;
  final String image11;
  final String image916;

  const WatchListItem({
    required this.name,
    required this.image,
    required this.duration,
    required this.id,
    required this.title,
    required this.desc,
    required this.image169,
    required this.encodedFilePath,
    required this.imageUrlThumbnail,
    required this.hlsFileId,
    required this.updatedAt,
    required this.image11,
    required this.image916,
  });
}

extension WatchListItemToEpisode on WatchListItem {
  // Conversion method to convert WatchListItem to Episode
  Episode toEpisode() {
    return Episode(
      id: this.id,
      title: this.title,
      description: this.desc,
      imageUrl_1: this.image,
      imageUrl_poster: this.image169,
      imageUrl_thumbnail: this.imageUrlThumbnail,
      hlsFileId: this.hlsFileId,
      encodedFilePath: this.encodedFilePath,
      updatedAt: this.updatedAt,
    );
  }
}

class WatchListView extends StatelessWidget {
  const WatchListView({Key? key}) : super(key: key);

  static const List<WatchListItem> _watchListItems = [
    // Your list of WatchListItem objects
    // WatchListItem(
    //   name: "1. A Study in Pink",
    //   image: "assets/images/ep_thum_1.png",
    //   duration: "54 min",
    //   id: "1001",
    //   title: "1. A Study in Pink",
    //   desc:
    //       "Vocal  Soumyadeep Sikdar (Murshidabadi) Lyric & Composition Ritam Sen , Dyuti Mukherjee Inspired by Jamuna Kinare by Prabha Atre  This is bengali transcreation of Prabha Atre's Jamuna Kinare. We sincerely tried to give a tribute to her magically soulful voice.  This music video was shot in Bolpur,in the winter of 2016.   Please do Like Share and Subscribe to share the spirit of Independent Music.",
    //   image169: "Jamunarteerebig(1).jpg",
    //   encodedFilePath:
    //       "2/1712733434210-vihCYo6Od8lsEPJ9/1712733434210-vihCYo6Od8lsEPJ9-pl.m3u8",
    //   imageUrlThumbnail: "",
    //   hlsFileId: "",
    //   updatedAt: 0,
    //   image11: "",
    //   image916: "",
    // ),
    // WatchListItem(
    //   name: "2. The Hounds of Baskerville",
    //   image: "assets/images/ep_thum_2.png",
    //   duration: "55 min",
    //   id: "1004",
    //   title: "2. The Hounds of Baskerville",
    //   desc:
    //       "If you're feeling down and need to hear a happy song, then try out Aajo Take Mone Po( Lo-Fi Version) by Taishi Nandi , Written by Ritam Sen & Composed by Manidipa Singha . This song is sure to make you feel better and remind you that you're not alone in your struggles. Listen and enjoy!",
    //   image169: "big1.jpg",
    //   encodedFilePath:
    //       "2/1712577821572-EEv2noMRAULqHtpF/1712577821572-EEv2noMRAULqHtpF-pl.m3u8",
    //   imageUrlThumbnail: "",
    //   hlsFileId: "",
    //   updatedAt: 0,
    //   image11: "",
    //   image916: "",
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0), // Add margins from the top
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Watch List',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ApplicationColor.text),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _watchListItems.length,
            itemBuilder: (context, index) {
              final watchListItem = _watchListItems[index];

              // Convert WatchListItem to Episode
              final episode = watchListItem.toEpisode();

              return GestureDetector(
                onTap: () => _handleEpisodeClick(
                    context, episode), // Call _handleEpisodeClick on tap
                child: Container(
                  width: double.infinity,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.9 * 0.3,
                          child: Image.asset(
                            episode.imageUrl_1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          episode.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleEpisodeClick(BuildContext context, Episode episode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EpisodeDetailsView(categoryContent: episode),
      ),
    );
  }
}
