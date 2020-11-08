import 'package:app_mobile/provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {

  final provider = Provider();

  final RxInt index = 0.obs;

  final routes = List<dynamic>();

  void init(dynamic route) async {
    for (int i = 0; i < 10; i++) {
      final tvenues = route['venues'].sublist(0, 5);
      tvenues.shuffle();

      final trests = route['restaurants'].sublist(0, 5);
      trests.shuffle();
      routes.add(
        {
          'venues': tvenues.sublist(0, 3)..add(trests.first),
        }
      );

    }
    // final places = await provider.getRestaurants();
    // restaurants.value = places;
  }

}