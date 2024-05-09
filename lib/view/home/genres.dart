import 'package:flutter/material.dart';
import 'package:ott_code_frontend/common/color_extension.dart';

class Genres extends StatefulWidget {
  const Genres({Key? key}) : super(key: key);

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Movie",
          style: TextStyle(
            color: ApplicationColor.text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          " | ",
          style: TextStyle(
            color: ApplicationColor.text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Adventure",
          style: TextStyle(
            color: ApplicationColor.text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          " | ",
          style: TextStyle(
            color: ApplicationColor.text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Comedy",
          style: TextStyle(
            color: ApplicationColor.text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          " | ",
          style: TextStyle(
            color: ApplicationColor.text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Family",
          style: TextStyle(
            color: ApplicationColor.text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
