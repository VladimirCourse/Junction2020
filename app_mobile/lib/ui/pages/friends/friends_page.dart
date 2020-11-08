import 'dart:math';

import 'package:app_mobile/processing/categories.dart';
import 'package:app_mobile/ui/pages/map/map_page.dart';
import 'package:app_mobile/ui/pages/profile/profile_page.dart';
import 'package:app_mobile/ui/pages/trip/trip_page.dart';
import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:app_mobile/ui/widgets/event_card.dart';
import 'package:app_mobile/ui/widgets/main_button.dart';
import 'package:app_mobile/ui/widgets/main_tag.dart';
import 'package:app_mobile/ui/widgets/question_card.dart';
import 'package:app_mobile/ui/widgets/venue_card.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';

import 'controller.dart';

class FriendsPage extends StatelessWidget {

  final _controller = Controller();

  FriendsPage() {
    _controller.init();
  } 

  void _onSelect(int index) {
    if (_controller.selected.contains(index)) {
      _controller.selected.remove(index);
    } else {
      _controller.selected.add(index);
    }
  }

  void _onFind() async {
    if (_controller.selected.length < 3) {
      Get.rawSnackbar(title: 'Not enough people', message: 'Please, select more friends', backgroundColor: AppColors.orange, animationDuration: Duration(milliseconds: 300));
    } else if (_controller.selected.length > 6) {
      Get.rawSnackbar(title: 'Too many people', message: 'Please, select less friends', backgroundColor: AppColors.orange,  animationDuration: Duration(milliseconds: 300));
    } else {
      try {
        final route = await _controller.route();
        Get.to(TripPage(route));
      } catch (ex) {
        Get.rawSnackbar(title: 'Something went wrong', message: 'Please, try again', backgroundColor: AppColors.orange,  animationDuration: Duration(milliseconds: 300));
      }
    }
  }

  Widget _buildFriend(int index) {
    final friend = _controller.friends[index];
    final selected = _controller.selected.contains(index);
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: ()=> _onSelect(index),
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    Get.to(ProfilePage(_controller.friends[index]));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.orange.withOpacity(0.5),
                      shape: BoxShape.circle
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.person,
                      color: AppColors.purple,
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(left: 15)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(friend['name'],
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.purple,
                        fontWeight: FontWeight.w600
                      ), 
                    ),
                    MainTag(
                      text: 'Online',
                      color: AppColors.orange,
                    )
                  ]
                ),
                Spacer(),
                Icon(Icons.check,
                  color: selected ? AppColors.purple : Colors.white
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        title: Text('Invite friends',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              ()=> Column(
                children: List.generate(_controller.friends.length,  
                  (index) => _buildFriend(index)
                )
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 70))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: MainButton(
          text: 'Find!',
          onPressed: _onFind
        )
      ),
    );
  }
}

