import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  MainButton({
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
  return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: AppColors.orange,
      textColor: Colors.white,
      padding: EdgeInsets.all(10),
      onPressed: onPressed,
      child: Text(text,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

}