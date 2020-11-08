import 'package:dio/dio.dart';
import 'package:geodesy/geodesy.dart';

class Provider {

  final _aitoDio = Dio(
    BaseOptions(
      baseUrl: 'https://harddays.aito.app/api/v1/', 
      headers: {
        'x-api-key': 'igpesf3rM3aKWgquRhcac49MaSE2947Q83OAPaUq'
      }
    )
  );

  final position = LatLng(60.1688627,24.934417);
  final geodesy = Geodesy();


  List<dynamic> _processFours(List<dynamic> results) {
    for (final place in results) {
      place['distance'] = geodesy.distanceBetweenTwoGeoPoints(position, LatLng(place['latitude'], place['longitude']));

      place['tags'] = List<String>();
      if (place['category_name'] != null) {
        final tags = place['category_name'].split(';') as List<String>;
        place['tags'] = [tags.first];
      }
    }
    final res = results.take(30).toList();
    res.sort((p1, p2)=> p1['distance'].compareTo(p2['distance']));
    return res;
  }

    List<dynamic> _processMovies(List<dynamic> results) {
    for (final place in results) {

      place['tags'] = List<String>();
      if (place['category_name'] != null) {
        final tags = place['category_name'].split(';') as List<String>;
        place['tags'] = [tags.first];
      }
    }
    return results;
  }

  Future<List<dynamic>> getRestaurants(double latitude, double longitude, List<String> categories) async {
    final res = await _aitoDio.post('/_similarity',
      data: {
        'from': 'rests',
        'similarity': {
          'latitude': latitude,
          'longitude': longitude,
          '\$or': categories.map((e) => {'category_id': e}).toList()
        },
        'limit': 100
      }
    );
    return _processFours(res.data['hits']);
  }

  Future<List<dynamic>> getVenues(double latitude, double longitude, List<String> categories) async {
    final res = await _aitoDio.post('/_similarity',
      data: {
        'from': 'venues',
        'similarity': {
          'latitude': latitude,
          'longitude': longitude,
          '\$or': categories.map((e) => {'category_id': e}).toList()
        },
        'limit': 100
      }
    );
    return _processFours(res.data['hits']);
  }

  Future<List<dynamic>> getEvents() async {
    final res = await _aitoDio.post('/_search',
      data: {
        'from': 'events',
        'limit': 100
      }
    );
    return _processFours(res.data['hits']);
  }

  Future<List<dynamic>> getMovies() async {
    final res = await _aitoDio.post('/_search',
      data: {
        'from': 'movies',
        'limit': 100
      }
    );
    return _processMovies(res.data['hits']);
  }
}