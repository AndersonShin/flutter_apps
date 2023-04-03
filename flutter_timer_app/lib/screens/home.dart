import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool onGoing = false;
  int totalPomo = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomo += 1;
        onGoing = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      onGoing = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      onGoing = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    String time = duration.toString().split(".").first.substring(2, 7);
    return time;
  }

  void onResetPressed() {
    setState(() {
      onGoing = false;
      totalSeconds = twentyFiveMinutes;
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              format(totalSeconds),
              style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                  child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                icon: onGoing
                    ? const Icon(Icons.pause_circle_outline_rounded)
                    : const Icon(Icons.play_circle_outline),
                onPressed: onGoing ? onPausePressed : onStartPressed,
              )),
              Center(
                  child: IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      icon: const Icon(Icons.reset_tv),
                      onPressed: onResetPressed))
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).cardColor),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodors",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                        Text(
                          "$totalPomo",
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
