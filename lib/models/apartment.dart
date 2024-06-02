class Apartment {
  final int id;
  final List<String> images;
  final String text;
  final String address;
  final String location;
  final int guest;
  final int bathroom;
  final int bedroom;
  final int price;

  Apartment({
    this.id = 0,
    required this.images,
    required this.text,
    required this.address,
    required this.location,
    required this.guest,
    required this.bathroom,
    required this.bedroom,
    required this.price,
  });
}
