import 'package:emergency_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool timerDone = false;
  List<Widget> currentOptions = [];
  Stopwatch callDuration = Stopwatch();

  void setOptions() {
    currentOptions = [
      optionButton("Fire", [optionButton("Cigarette", [])]),
      optionButton("Natural Disaster", []),
      optionButton("Accident", []),
      optionButton("Medical", [])
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
          Text(
            callDuration.elapsed.toString().split('.').first.padLeft(8, "0"),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Describe your emergency",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: ListView(
                children: currentOptions,
              ),
            ),
          )
        ],
      ),
    );
  }

  Center callTimer(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 128),
          Text(
            "Call will start...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
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
                callDuration.start();
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

  Widget optionButton(String text, newList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          setState(
            () {
              currentOptions = newList;
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: TextStyle(color: AppColors.primary, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
