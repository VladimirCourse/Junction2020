import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:app_mobile/ui/widgets/main_button.dart';
import 'package:app_mobile/ui/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';

import 'controller.dart';

class MapPage extends StatelessWidget {
  
  final _controller = Controller();

  MapPage() {
    _controller.init();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        title: Text('Map',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(
        ()=> FlutterMap(
          options: MapOptions(
            center: LatLng(23.752304, -99.1669132),
            zoom: 5.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']
            ),
            MarkerLayerOptions(
              markers: List.generate(_controller.restaurants.length, 
                (index) {
                  final place = _controller.restaurants[index];
                  return Marker(
                    width: 20.0,
                    height: 20.0,
                    point: LatLng(place['latitude'], place['longitude']),
                    builder: (ctx) =>
                    Container(
                      color: Colors.red,
                      width: 30,
                      height: 30,
                      child: Text('$index',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

