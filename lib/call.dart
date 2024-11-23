import 'package:emergency_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool timerDone = false;
  List<Widget> currentOptions = [];

  void setOptions() {
    currentOptions = [
      optionButton("Fire", [
        optionButton("Ordinary Fire", []),
        optionButton("Electrical Fire", []),
        optionButton("Forest Fire", []),
        optionButton("Gas Fire", []),
        optionButton("Liquid Fire", [])
      ]),
      optionButton("Natural Disaster", [
        optionButton("Earthquake", []),
        optionButton("Typhoon", []),
        optionButton("Flood", []),
        optionButton("Volcanic", []),
      ]),
      optionButton("Accident", [
        optionButton("Traffic Accident", []),
        optionButton("Slips, Trips, Falls", []),
        optionButton("Industrial Accident", []),
        optionButton("Sports Accidents", []),
      ]),
      optionButton("Medical", [
        optionButton("Overdose", []),
        optionButton("Poisoning", []),
        optionButton("Stroke", []),
        optionButton("Heart Attack", []),
        optionButton("Seizure", []),
      ])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: timerDone ? incall() : callTimer(context),
    );
  }

  Widget incall() {
    return Center(
      child: Column(
        children: [
          CallDuration(),
          Text(
            "Describe your emergency",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          showOptions(currentOptions),
        ],
      ),
    );
  }

  Widget showOptions(List<Widget> optionList) {
    if (optionList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          "Help is on the way! Please DO NOT turn off the device.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: currentOptions,
          ),
        ),
      );
    }
  }

  Center callTimer(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Now calling nearest responder...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          LinearTimer(
            duration: Duration(seconds: 3),
            forward: false,
            onTimerEnd: () {
              setState(() {
                setOptions();
                timerDone = true;
              });
            },
          ),
          SizedBox(height: 128),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "CANCEL",
              style: TextStyle(color: AppColors.primary, fontSize: 24),
            ),
          )
        ],
      ),
    );
  }

  Widget optionButton(String text, List<Widget> newList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(
            () {
              currentOptions = newList;
            },
          );
        },
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.primary, fontSize: 32),
          ),
        ),
      ),
    );
  }
}

class CallDuration extends StatefulWidget {
  const CallDuration({super.key});

  @override
  State<CallDuration> createState() => _CallDurationState();
}

class _CallDurationState extends State<CallDuration> {
  final StopWatchTimer _callStopwatch = StopWatchTimer();

  @override
  void dispose() {
    super.dispose();
    _callStopwatch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _callStopwatch.onStartTimer();
    return StreamBuilder(
        stream: _callStopwatch.rawTime,
        initialData: _callStopwatch.rawTime.value,
        builder: (context, snapshot) {
          final value = snapshot.data!;
          final displayTime = StopWatchTimer.getDisplayTime(value,
              hours: false, milliSecond: false);
          return Text(
            displayTime,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          );
        });
  }
}
