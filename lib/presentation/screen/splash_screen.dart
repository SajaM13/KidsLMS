import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/presentation/screen/course_path.dart';
import 'package:kids_lms_project/presentation/screen/on_boarding_screen.dart';
import 'package:kids_lms_project/presentation/widgets/Text1.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    checkLoginStatus();

    // Future.delayed(Duration(seconds: 3),(){
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //       builder: (_)=>OnBoardingScreen(),
    //
    //   ));
    // });


  }
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => course_path(levelId: 1,),
        ),
      );
    } else {

      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => OnBoardingScreen(),
        ),
      );
    }
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [MyAppColors.verylightBlue,MyAppColors.purple],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset( 'assets/images/splash.png'),
            SizedBox(height: 10,),
            Text1(value: 'KIDS LMS', Size: 38),
          ],
        ),
      ),
    );
  }
}
