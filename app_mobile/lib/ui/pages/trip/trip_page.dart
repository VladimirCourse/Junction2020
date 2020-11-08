import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:app_mobile/ui/widgets/main_button.dart';
import 'package:app_mobile/ui/widgets/question_card.dart';
import 'package:app_mobile/ui/widgets/venue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';

import 'controller.dart';

class TripPage extends StatelessWidget {
  
  final Map<String, dynamic> route;

  final _controller = Controller();

  TripPage(this.route) {  
    _controller.init(route);
  } 

  void _onSwipe(int index) {
    _controller.index.value = index;
  }

  List<Polyline> _buildPolylines() {
    final polys = List<Polyline>();
    for (final friend in route['friends']) {
      final points = List<LatLng>();
      points.add(LatLng(route['latitude'], route['longitude']));
      points.add(LatLng(friend['latitude'], friend['longitude']));
      polys.add(
        Polyline(
          color: AppColors.orange,
          strokeWidth: 3,
          points: points,
          isDotted: true,
        )
      );
    }
    final places = _controller.routes[_controller.index.value]['venues'];
    final points = List<LatLng>();
    points.add(LatLng(route['latitude'], route['longitude']));
    for (final place in places) {
      points.add(LatLng(place['latitude'], place['longitude']));
    }
    polys.add(
      Polyline(
        color: AppColors.purple,
        strokeWidth: 3,
        points: points,
        isDotted: true,
      )
    );

    return polys;
  }

  List<Marker> _buildMarkers() {
    final markers = List<Marker>();

    for (final friend in route['friends']) {
      markers.add(
        Marker(
          width: 10.0,
          height: 10.0,
          point: LatLng(friend['latitude'], friend['longitude']),
          builder: (ctx) =>
          Container(
            decoration: BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle
            ),
            width: 10,
            height: 10,
          ),
        )
      );
    }
    final places = _controller.routes[_controller.index.value]['venues'];
    for (final place in places) {
      markers.add(
         Marker(
          width: 10.0,
          height: 10.0,
          point: LatLng(place['latitude'], place['longitude']),
          builder: (ctx) =>
          Container(
            decoration: BoxDecoration(
              color: AppColors.purple,
              shape: BoxShape.circle
            ),
            width: 10,
            height: 10,
          ),
        )
      );
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.purple,
        elevation: 0,
      ),
      body: Obx(() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(route['latitude'], route['longitude']),
                zoom: 14.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: 'https://api.mapbox.com/styles/v1/vovan123/cjm3dcned9ve12snxbsnfoy38/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                  additionalOptions: {
                    'accessToken': 'pk.eyJ1Ijoidm92YW4xMjMiLCJhIjoiY2o3aXNicTFhMW9jbDJxbWw3bHNqMW92MCJ9.N1hCLnBrJjdX0JmYuA8bOw',
                    'id': 'streets'
                  },
                ),
                PolylineLayerOptions(
                  polylines: _buildPolylines()
                ),
                MarkerLayerOptions(
                  markers: _buildMarkers(),
                )
              ],
            ),
          ),
          Container(
            height: Get.height * 0.5 - 100,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                final places = _controller.routes[index]['venues'];
                return Card(
                  color: AppColors.purple,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                            child: Text('Places',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                        ),
                        Padding(padding: const EdgeInsets.only(top: 10)),
                        Container(
                          height: Get.width * 0.4,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(places.length, 
                              (index) {
                                final place = places[index];
                                return VenueCard(
                                  width: Get.width * 0.35,
                                  height: Get.width * 0.4,
                                  name: place['name'],
                                  distance: place['distance'],
                                  tags: place['tags']
                                );
                              }
                            )
                          ),
                        ),                        
                      ],
                    )
                  )
                );
              },
              onIndexChanged: _onSwipe,
              itemCount: _controller.routes.length,
              itemWidth: Get.width - 50,
              layout: SwiperLayout.STACK,
            )
          )
        ]
      )
      )
    );
  }
}

