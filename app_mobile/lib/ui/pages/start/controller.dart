import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  // RxInt index = 0.obs;
  RxDouble opacity = 0.0.obs;
  RxSet<String> selected = Set<String>().obs;

  void save(bool multiple, String field) async {
    final preferences = await SharedPreferences.getInstance();
    if (!multiple) {
      await preferences.setString(field, selected.first);
    } else {
      await preferences.setStringList(field, selected.toList());
    }
  }

  Future<bool> checkAll() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.containsKey('age') && preferences.containsKey('activity') && preferences.containsKey('interests');
  }
}