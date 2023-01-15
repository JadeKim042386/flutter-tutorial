import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 10;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
        totalPomodoros = totalPomodoros + 1;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    if (!isRunning) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        onTick,
      );
    }
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onTimeResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = twentyFiveMinutes;
    });
  }

  void onPomoResetPressed() {
    setState(() {
      totalPomodoros = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Transform.translate(
                offset: const Offset(25, 20),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          totalSeconds >= 60 * 60
                              ? '${(totalSeconds ~/ (60 * 60)).toString().padLeft(2, '0')}:${((totalSeconds % (60 * 60)) ~/ 60).toString().padLeft(2, '0')}:${((totalSeconds % (60 * 60)) % 60).toString().padLeft(2, '0')}'
                              : '${(totalSeconds ~/ 60).toString().padLeft(2, '0')}:${(totalSeconds % 60).toString().padLeft(2, '0')}',
                          style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontSize: 89,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          iconSize: 25,
                          color: Theme.of(context).cardColor,
                          onPressed: onTimeResetPressed,
                          icon: const Icon(Icons.autorenew),
                        )
                      ]),
                ),
              )),
          Flexible(
              flex: 2,
              child: Transform.translate(
                  offset: const Offset(0, 50),
                  child: Column(children: [
                    IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      icon: Icon(isRunning
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline),
                    )
                  ]))),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                iconSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                onPressed: onPomoResetPressed,
                                icon: const Icon(Icons.autorenew),
                              ),
                            ],
                          ),
                          Text('Pomodoros',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              )),
                          Text('$totalPomodoros',
                              style: TextStyle(
                                fontSize: 58,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
