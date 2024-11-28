import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelp_restaurant_finder/provider/restaurant_provider.dart';
import 'package:yelp_restaurant_finder/widgets/restaurant_card.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final _locationController = TextEditingController();

  void _fetchRestaurants() {
    if (_locationController.text.isNotEmpty) {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchRestaurants(_locationController.text);
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Restaurants'),),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0),
            child:Row(
              children: [
                Expanded(child: TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Enter location(e.g., "Markham, ON")',
                    border: OutlineInputBorder()
                  ),
                )),

                 const SizedBox(width: 8,),
                
                ElevatedButton(
                    onPressed: _fetchRestaurants,
                    child: const Text("Search"),
                )
              ],
            ),
          ),

          Expanded(
              child: Consumer<RestaurantProvider>(
                builder: (context, provider, _){
                  if(provider.isLoading){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else if(provider.restaurants.isEmpty){
                    return Center(child: Text('No Restaurants Found'),);
                  }else{
                    return ListView.builder(
                    itemCount: provider.restaurants.length,
                      itemBuilder: (context, i) =>
                      RestaurantCard(provider.restaurants[i]),
                    );
                  }
                },
              )
          )
        ],
      ),
    );
  }
}

