import 'package:flutter/material.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/enviorment_var.dart';
import 'package:ott_code_frontend/models/Song.dart';
import 'package:ott_code_frontend/view/home/action_buttons.dart';
import 'package:ott_code_frontend/view/home/movie_player.dart';
import 'package:hive/hive.dart';
import 'package:ott_code_frontend/models/User.dart';
import 'package:ott_code_frontend/view/login/login_view.dart';

class CategoryDetailsView extends StatefulWidget {
  const CategoryDetailsView({Key? key, required this.categoryContent})
      : super(key: key);

  final Song categoryContent;

  @override
  _CategoryDetailsViewState createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  bool _isPlaying = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    String description = widget.categoryContent.description;
    String displayDescription = _isExpanded || description.length <= 200
        ? description
        : description.substring(0, 200) + '...';

    return Scaffold(
      backgroundColor: ApplicationColor.bgColor,
      body: _isPlaying
          ? MoviePlayer(
              videoUrl:
                  '${EnvironmentVars.bucketUrl}/${widget.categoryContent.encodedFilePath}',
              videoText: widget.categoryContent.title,
            )
          : SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: media.width,
                            height: media.width * 0.8,
                            child: ClipRect(
                              child: Image.network(
                                '${EnvironmentVars.bucketUrl}/${widget.categoryContent.imageUrl_poster}',
                                width: media.width,
                                height: media.width,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                          Positioned(
                            top: media.width * 0.4,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  print("Playing............1");
                                  //_isPlaying = true;
                                  userAccountCheck();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              icon: const Icon(
                                Icons.play_circle_filled,
                                color: Colors.white,
                                size: 60,
                              ),
                              label: Text(''),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.categoryContent.title,
                              style: TextStyle(
                                color: ApplicationColor.text,
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              displayDescription,
                              style: TextStyle(
                                color: ApplicationColor.text,
                                fontSize: 15,
                              ),
                            ),
                            if (description.length > 200)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Text(_isExpanded ? '▲' : '▼'),
                              ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            userAccountCheck();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ApplicationColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Watch Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const ActionButtons()
                    ],
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
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
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> userAccountCheck() async {
    var box = await Hive.openBox<User>('userTable');
    var user = box.get('user');
    var accountId = user?.accountId ?? '';
    print("Account ID ==> $accountId");
    if (accountId != '') {
      _isPlaying = true;
    } else {
      _isPlaying = false;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
    }
  }
}
