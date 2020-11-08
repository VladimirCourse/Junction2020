import 'dart:math';

import 'package:app_mobile/processing/categories.dart';
import 'package:app_mobile/provider/provider.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geodesy/geodesy.dart';
import 'package:sortedmap/sortedmap.dart';

class Controller extends GetxController {
  
  final provider = Provider();

  RxSet<int> selected = Set<int>().obs;

  final List<dynamic> friends = [];

  void init() {
    final faker = Faker();
    final random = Random();
    for (int i = 0; i < 15; i++) {
      final name = faker.person.name();
      final activity = Categories.activities.keys.elementAt(random.nextInt(Categories.activities.length));
      final age = Categories.ages.keys.elementAt(random.nextInt(Categories.ages.length));
      final interests = Categories.interests.keys.toList();
      interests.shuffle();
      // final cultures = Categories.culture.keys.toList();
      // cultures.shuffle();

      final latitude =  provider.position.latitude  + random.nextDouble() * 0.007;
      final longitude = provider.position.longitude  + random.nextDouble() * 0.007;

      friends.add(
        {
          'name': name,
          'age': age,
          'activity': activity,
          'latitude': latitude,
          'longitude': longitude,
          'interests': interests.sublist(0, interests.length ~/ 3),
          //'culture': cultures.sublist(0, cultures.length ~/ 3)
        }
      );
    }
  }

  List<String> popularCategories(Map<String, int> categories) {
    final map = SortedMap(Ordering.byValue());
    map.addAll(categories);
    final list = map.keys.map((e) => e as String).toList().reversed.toList();
    return list.sublist(0, min(5, list.length));
  }


  Future<Map<String, dynamic>> route() async {
    // middle point
    double latitude = provider.position.latitude;
    double longitude = provider.position.longitude;

    for (final i in selected) {
      latitude += friends[i]['latitude'];
      longitude += friends[i]['longitude'];
    }

    latitude /= (selected.length + 1);
    longitude /= (selected.length + 1);

    // common interests
    final preferences = await SharedPreferences.getInstance();
    final age = preferences.getString('age');
    final activity = preferences.getString('activity');
    final interests = preferences.getStringList('interests');

    final restCats = Categories.count('rest_categories', age, activity, interests);
    final venueCats = Categories.count('venue_categories', age, activity, interests);

    final friendsRes = [];

    for (final i in selected) {
      final friend = friends[i];
      friendsRes.add(friend);
      final rc = Categories.count('rest_categories', friend['age'], friend['activity'], friend['interests']);
      final vc = Categories.count('venue_categories', friend['age'], friend['activity'], friend['interests']);

      for (final cat in rc.keys) {
        if (!restCats.containsKey(cat)) {
          restCats[cat] = 0;
        }
        restCats[cat] += rc[cat];
      }

      for (final cat in vc.keys) {
        if (!venueCats.containsKey(cat)) {
          venueCats[cat] = 0;
        }
        venueCats[cat] += vc[cat];
      }
    }

    final venues = await provider.getVenues(latitude, longitude, popularCategories(venueCats));
    final restaurants = await provider.getRestaurants(latitude, longitude, popularCategories(restCats));  

    return {
      'venues': venues,
      'restaurants': restaurants,
      'friends': friendsRes,
      'latitude': latitude,
      'longitude': longitude,

    };
  }

}