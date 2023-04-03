import 'package:flutter/material.dart';
import 'package:toonflix_app/screens/detail_screen.dart';

class WebToonWidget extends StatelessWidget {
  final String title, thumb, id;

  const WebToonWidget(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(title: title, thumb: thumb, id: id)));
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 15),
                    color: Colors.black.withOpacity(0.5))
              ], borderRadius: BorderRadius.circular(10)),
              width: 250,
              child: Image.network(
                thumb,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
