

import 'package:flutter/material.dart';
import 'package:kids_lms_project/app_router.dart';


void main() {
  runApp(MyApp(
    approuter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.approuter,
  }) : super(key: key);
  final AppRouter approuter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: FutureBuilder<SharedPreferences>(
      //   future: SharedPreferences.getInstance(),
      //   builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else if (snapshot.hasData) {
      //       SharedPreferences prefs = snapshot.data!;
      //       bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      //
      //       if (isLoggedIn) {
      //         return course_path();
      //       } else {
      //         return SplashScreen();
      //       }
      //     } else {
      //       return Container();
      //     }
      //   },
      // ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: approuter.generateRout,
    );
  }
}
