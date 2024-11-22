import 'package:emergency_app/call.dart';
import 'package:emergency_app/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void call(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CallScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person,
          ),
          color: Colors.white,
          style: IconButton.styleFrom(backgroundColor: AppColors.secondary),
        ),
        title: Text("Emergency App"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.all(24),
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.secondary, width: 2)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning,
                            color: AppColors.primary,
                          ),
                          Text(
                            "WARNING",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                      Text(
                        "Your data is currently being recorded. Pressing the button will send your information to respective authorities.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, height: 1.3),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 200,
                width: 200,
                child: ElevatedButton(
                  onPressed: () => call(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, elevation: 10),
                  child: Text(
                    "SOS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
