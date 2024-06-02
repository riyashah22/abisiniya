class Vehicle {
  final int id;
  final String name;
  final String address;
  final String city;
  final String country;
  final String make;
  final String model;
  final int year;
  final String engineSize;
  final String fuelType;
  final String weight;
  final String color;
  final String transmission;
  final int price;
  final String status;
  final String images;

  Vehicle(
      {this.id = 0,
      required this.name,
      required this.address,
      required this.city,
      required this.country,
      required this.make,
      required this.model,
      required this.year,
      required this.engineSize,
      required this.fuelType,
      required this.weight,
      required this.color,
      required this.transmission,
      required this.price,
      required this.status,
      required this.images});
}
