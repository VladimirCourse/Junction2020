import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {

  final String text;
  final Color color;
  final Color textColor;
  QuestionCard({this.text, this.color = Colors.white, this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: color,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Icon(Icons.access_alarm),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}