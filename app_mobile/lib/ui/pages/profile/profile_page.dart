import 'package:app_mobile/processing/categories.dart';
import 'package:app_mobile/ui/pages/map/map_page.dart';
import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:app_mobile/ui/widgets/event_card.dart';
import 'package:app_mobile/ui/widgets/main_button.dart';
import 'package:app_mobile/ui/widgets/main_tag.dart';
import 'package:app_mobile/ui/widgets/question_card.dart';
import 'package:app_mobile/ui/widgets/venue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ProfilePage extends StatelessWidget {
  
  final dynamic user;

  ProfilePage(this.user);

  Widget _buildCategory(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10, top: 20),
      child: Text(name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w300
        ),
      ),
    );
  }

  Widget _buildList(List<String> names) {
    return Container(
      height: Get.height * 0.15,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(names.length, 
          (index) {
            return Container(
              margin: const EdgeInsets.only(left: 15),
              width: Get.height * 0.15,
              child: QuestionCard(
                text: names[index],
              ),
            );
          }
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        title: Text('',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.person,
                  color: AppColors.purple,
                  size: 50,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(user['name'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: MainTag(
                text: 'Online',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('7  ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                  Text('Places visited',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white
                    ),
                  ),
                ]
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategory('Interests'),
                  _buildList(List<String>.from(user['interests'].map((e)=> Categories.interests[e]['name']))),
                  // _buildCategory('Culture'),
                  // _buildList(List<String>.from(user['culture'].map((e)=> Categories.culture[e]['name'])))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

