import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../model/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  bool _isLoading = false;

  List<Restaurant> get restaurants => _restaurants;
  bool get isLoading => _isLoading;

  Future<void> fetchRestaurants(String location) async {
    final api_key = dotenv.env['YELP_API_KEY'];
    final url = Uri.parse(
        'https://api.yelp.com/v3/businesses/search?term=restaurants&location=$location');

    _isLoading = true;
    notifyListeners();
    try{
    final response =
        await get(
            url,
            headers: {'Authorization': 'Bearer $api_key'}
        );
    if(response.statusCode == 200){
      final data = json.decode(response.body)['businesses'] as List;
      _restaurants =
          data.map((json) => Restaurant.fromJson(json)).toList();
      notifyListeners();
    }else {
      throw Exception('failed to load restaurants');
    }
    } catch (error){
      _restaurants = [];
      rethrow;
    }finally{
      _isLoading = false;
      notifyListeners();
    }

  }
}
