// To parse this JSON data, do
//
//     final officesModel = officesModelFromMap(jsonString);

import 'dart:convert';

class Office {
  Office({
    required this.address,
    required this.coord,
    required this.phone,
  });

  final String address;
  final Coord coord;
  final int phone;
  String? id;

  factory Office.fromJson(String str) => Office.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Office.fromMap(Map<String, dynamic> json) => Office(
        address: json['address'],
        coord: Coord.fromMap(json['coord']),
        phone: json['phone'],
      );

  Map<String, dynamic> toMap() => {
        'address': address,
        'coord': coord.toMap(),
        'phone': phone,
      };
}

class Coord {
  Coord({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  factory Coord.fromJson(String str) => Coord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
        lat: json['lat'].toDouble(),
        lng: json['lng'].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'lat': lat,
        'lng': lng,
      };
}
