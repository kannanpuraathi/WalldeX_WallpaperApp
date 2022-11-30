import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../screens/open_screen.dart';

class GridViewWidget extends StatelessWidget {
  final List images;
  ScrollController scroll;

  GridViewWidget({Key? key, required this.images, required this.scroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3),
      child: GridView.builder(
        controller: scroll,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 3,
          crossAxisCount: 2,
          mainAxisSpacing: 3,
          childAspectRatio: 9 / 16,
        ),
        itemCount: images.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return InkWell(
            child: Card(
              child: Image.network(
                images[index]['src']['portrait'],
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              final String i = images[index]['src']['portrait'].toString();
              final String j = images[index]['src']['original'].toString();
              if (kDebugMode) {
                print(i);
                print(j);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenScreen(
                    url: i,
                    downloadUrl: j,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}