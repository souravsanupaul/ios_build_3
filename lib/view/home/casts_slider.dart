import 'package:flutter/material.dart';
import 'package:ott_code_frontend/enviorment_var.dart';

class CastsSliders extends StatelessWidget {
  const CastsSliders({Key? key, required this.media, required this.snapshot})
      : super(key: key);

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
            child: SizedBox(
              width: media.width * 0.45,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    '${EnvironmentVars.profileImage}${snapshot.data![index].profilePath}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          snapshot.data![index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
