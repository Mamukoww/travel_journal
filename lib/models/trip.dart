import 'dart:convert';

class Trip {
  String title;
  String date;
  String description;
  String photoUrl;
  String weather;

  Trip({required this.title, required this.date, required this.description, required this.photoUrl, this.weather = ''});

  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date,
    'description': description,
    'photoUrl': photoUrl,
    'weather': weather,
  };

  static Trip fromJson(Map<String, dynamic> json) => Trip(
    title: json['title'],
    date: json['date'],
    description: json['description'],
    photoUrl: json['photoUrl'],
    weather: json['weather'],
  );
}
