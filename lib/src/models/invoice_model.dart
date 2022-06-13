import 'dart:convert';

class Invoice {
  Invoice({
    required this.date,
    required this.path,
  });

  final String date;
  final String path;

  factory Invoice.fromJson(String str) => Invoice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Invoice.fromMap(Map<String, dynamic> json) => Invoice(
        date: json['date'],
        path: json['path'],
      );

  Map<String, dynamic> toMap() => {
        'date': date,
        'path': path,
      };
}
