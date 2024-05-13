class Vehicle {
  final String name;
  final String address;
  final String city;
  final String country;
  final String make;
  final String model;
  final int year;
  final String engine_size;
  final String weight;
  final String color;
  final String transmission;
  final int price;
  final String status;
  final List<String> images;

  Vehicle(
      {required this.name,
      required this.address,
      required this.city,
      required this.country,
      required this.make,
      required this.model,
      required this.year,
      required this.engine_size,
      required this.weight,
      required this.color,
      required this.transmission,
      required this.price,
      required this.status,
      required this.images});
}
