import 'package:app_mobile/provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {

  final provider = Provider();

  RxList<dynamic> restaurants = List<dynamic>().obs;

  void init() async {
    // final places = await provider.getRestaurants();
    // restaurants.value = places;
  }

}