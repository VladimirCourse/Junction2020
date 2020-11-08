import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:flutter/material.dart';

class MainTag extends StatelessWidget {

  final String text;
  final Color color;
  final Color textColor;
  MainTag({this.text, this.color = AppColors.orange, this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.only(right: 5, top: 5),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      alignment: Alignment.center,
      child: Text(text,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w400
        ), 
      ),

    );
  }

}