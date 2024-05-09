import 'package:flutter/material.dart';
import 'package:ott_code_frontend/common_widgets/rounded_text_field.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/api/api.dart';
import 'package:ott_code_frontend/enviorment_var.dart';
import 'package:ott_code_frontend/models/Categories.dart';
import 'package:ott_code_frontend/view/home/CategoryDetailsView.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController txtSearch = TextEditingController();
  late Future<List<Categories>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = Api().getCategories(searchString: '');
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ApplicationColor.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: RoundedTextField(
              title: "",
              controller: txtSearch,
              hintText: "Search here...",
              left: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.search,
                  size: 20,
                  color: ApplicationColor.bgColor,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _categoriesFuture = Api().getCategories(searchString: value);
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Categories>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Categories>? categories = snapshot.data;
                  // Filter out categories that don't have any songs
                  categories?.removeWhere((category) => category.songs.isEmpty);
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    itemCount: categories?.length ?? 0,
                    itemBuilder: (context, index) {
                      var category = categories![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text(
                                    category.title,
                                    style: TextStyle(
                                      color: ApplicationColor.text,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: ApplicationColor.subText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: media.width * 0.4,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                scrollDirection: Axis.horizontal,
                                itemCount: category.songs.length,
                                itemBuilder: (context, index) {
                                  var song = category.songs[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryDetailsView(
                                            categoryContent: song,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      color: ApplicationColor.bgColor,
                                      width: media.width * 0.25,
                                      height: media.width * 0.32,
                                      child: ClipRect(
                                        child: Image.network(
                                          '${EnvironmentVars.bucketUrl}/${song.imageUrl_poster}',
                                          width: media.width * 0.25,
                                          height: media.width * 0.32,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
