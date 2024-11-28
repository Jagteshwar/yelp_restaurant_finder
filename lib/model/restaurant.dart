class Restaurant {
  final String name;
  final String imageUrl;
  final String address;
  final double rating;

  Restaurant(
      {required this.name,
      required this.imageUrl,
      required this.address,
      required this.rating});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        name: json['name'],
        imageUrl: json['image_url'],
        address: (json['location']['display_address'] as List).join(', '),
        rating: json['rating']);
  }
}
