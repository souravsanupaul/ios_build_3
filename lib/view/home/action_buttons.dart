import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () {
                // Add your functionality for "Watchlist Add" here
                print('Watchlist Add button pressed');
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const Text(
              'Watchlist',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                // Implement Share functionality
                Share.share(
                    'Check out this amazing video! https://indimuse.in/');
              },
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
            const Text(
              'Share',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                // Add your functionality for "Trailer" here
                print('Trailer button pressed');
              },
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            ),
            const Text(
              'Trailer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
