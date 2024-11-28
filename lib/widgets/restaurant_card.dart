import 'package:flutter/material.dart';
import '../model/restaurant.dart';


class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantCard(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(
          restaurant.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(restaurant.name),
        subtitle: Text('${restaurant.address}\nRating: ${restaurant.rating}'),
        isThreeLine: true,
      ),
    );
  }
}
