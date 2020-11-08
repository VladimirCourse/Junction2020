import 'package:app_mobile/ui/pages/main/main_page.dart';
import 'package:app_mobile/ui/pages/start/start_page.dart';
import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryTextTheme: TextTheme(
          bodyText1:  TextStyle(
            color: AppColors.purple
          ),
          bodyText2:  TextStyle(
            color: AppColors.purple
          ),
          headline6: TextStyle(
            fontSize: 24,
            color: AppColors.purple,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
      home: StartPage(0),
    );
  }
}

