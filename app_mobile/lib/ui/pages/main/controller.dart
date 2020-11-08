import 'dart:math';

import 'package:app_mobile/processing/categories.dart';
import 'package:app_mobile/provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geodesy/geodesy.dart';
import 'package:sortedmap/sortedmap.dart';

class Controller extends GetxController {

  final provider = Provider();

  RxList<dynamic> special = List<dynamic>().obs;
  RxList<dynamic> restaurants = List<dynamic>().obs;
  RxList<dynamic> events = List<dynamic>().obs;
  RxList<dynamic> movies = List<dynamic>().obs;

  void init() async {
    final preferences = await SharedPreferences.getInstance();
    final age = preferences.getString('age');
    final activity = preferences.getString('activity');
    final interests = preferences.getStringList('interests');

    final restCats = Categories.count('rest_categories', age, activity, interests);
    final venueCats = Categories.count('venue_categories', age, activity, interests);

    special.value = await provider.getVenues(provider.position.latitude, provider.position.longitude, popularCategories(venueCats));
    restaurants.value = await provider.getRestaurants(provider.position.latitude, provider.position.longitude, popularCategories(restCats));    
    events.value = await provider.getEvents();    
    movies.value = await provider.getMovies();
  }

  List<String> popularCategories(Map<String, int> categories) {
    final map = SortedMap(Ordering.byValue());
    map.addAll(categories);
    final list = map.keys.map((e) => e as String).toList().reversed.toList();
    return list.sublist(0, min(5, list.length));
  }

  Future<dynamic> user() async {
     final preferences = await SharedPreferences.getInstance();
     return {
       'name': 'Your Name',
       'interests': preferences.getStringList('interests'),
     };
  }

}