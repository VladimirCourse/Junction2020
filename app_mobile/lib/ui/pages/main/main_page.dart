import 'package:app_mobile/ui/pages/friends/friends_page.dart';
import 'package:app_mobile/ui/pages/map/map_page.dart';
import 'package:app_mobile/ui/pages/profile/profile_page.dart';
import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:app_mobile/ui/widgets/event_card.dart';
import 'package:app_mobile/ui/widgets/main_button.dart';
import 'package:app_mobile/ui/widgets/question_card.dart';
import 'package:app_mobile/ui/widgets/venue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MainPage extends StatelessWidget {
  
  final _controller = Controller();

  MainPage() {
    _controller.init();
  } 

  Widget _buildCategory(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 10, top: 20),
      child: Text(name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w300
        ),
      ),
    );
  }

  Widget _buildSpecial() {
    return Obx(
      ()=> Container(
        height: Get.width * 0.4,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(_controller.special.length, 
            (index) {
              final place = _controller.special[index];
              return VenueCard(
                width: Get.width * 0.35,
                height: Get.width * 0.4,
                name: place['name'],
                distance: place['distance'],
                tags: place['tags'],
                imagePl: 'assets/sight.jpg',
              );
            }
          )
        ),
      ),
    );
  }

   Widget _buildEvents() {
    return Obx(
      ()=> Container(
        height: Get.width * 0.4,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(_controller.events.length, 
            (index) {
              final place = _controller.events[index];
              return EventCard(
                width: Get.width * 0.3,
                height: Get.width * 0.4,
                name: place['name'],
                distance: place['distance'],
                tags: place['tags']
              );
            }
          )
        ),
      ),
    );
  }

  Widget _buildRestaurants() {
    return Obx(
      ()=> Container(
        height: Get.width * 0.35,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(_controller.restaurants.length, 
            (index) {
              final place = _controller.restaurants[index];
              return VenueCard(
                width: Get.width * 0.4,
                height: Get.width * 0.35,
                name: place['name'],
                distance: place['distance'],
                tags: place['tags']
              );
            }
          )
        ),
      ),
    );
  }

   Widget _buildMovies() {
    return Obx(
      ()=> Container(
        height: Get.width * 0.35,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(_controller.movies.length, 
            (index) {
              final place = _controller.movies[index];
              return EventCard(
                width: Get.width * 0.3,
                height: Get.width * 0.35,
                name: place['name'],
                tags: place['tags'],
                imageUrl: place['image_path'],
              );
            }
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Your Name',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: InkWell(
          onTap: () async {
            final profile = await _controller.user();
            Get.to(
              ProfilePage(
                profile
              )
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.all(0),
            child: Icon(Icons.person,
              color: AppColors.purple,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategory('Special for you'),
            _buildSpecial(),
            _buildCategory('Events'),
            _buildEvents(),
            _buildCategory('Where to eat'),
            _buildRestaurants(),
            _buildCategory('Movies'),
            _buildMovies(),
            Padding(padding: const EdgeInsets.only(bottom: 70))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: MainButton(
          text: 'Create Trip!',
          onPressed: () {
            Get.to(FriendsPage());
          }
        )
      ),
    );
  }
}

