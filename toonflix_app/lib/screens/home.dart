import 'package:flutter/material.dart';
import 'package:toonflix_app/service/api_service.dart';
import 'package:toonflix_app/widgets/webtoon_widget.dart';

import '../models/webtoon.dart';

// FutureBuilder O

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebToon>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebToon>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebToonWidget(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 40);
      },
    );
  }
}

// FutureBuilder 사용 X
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<WebToon> webtoons = [];
//   bool isLoading = true;

//   void waitForWebToons() async {
//     webtoons = await ApiService.getTodaysToons();
//     isLoading = false;
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     waitForWebToons();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 2,
//         foregroundColor: Colors.green,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "오늘의 웹툰",
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
