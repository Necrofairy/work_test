import 'package:http/http.dart' as http;
import 'dart:convert';

class UnsplashPhotosList {
  final List<UnsplashPhotos> photos;

  UnsplashPhotosList({required this.photos});

  factory UnsplashPhotosList.fromJson(List<dynamic> json) {
    var list = json.map((e) => UnsplashPhotos.fromJson(e)).toList();
    return UnsplashPhotosList(photos: list);
  }
}

class UnsplashPhotos {
  final String id;
  final Urls urls;
  final User name;

  UnsplashPhotos({required this.urls, required this.name, required this.id});

  factory UnsplashPhotos.fromJson(Map<String, dynamic> json) {
    return UnsplashPhotos(
        urls: Urls.fromJson(json['urls']),
        name: User.fromJson(json['user']), id: json['id'] as String);
  }
}

class Urls {
  final String full;
  final String raw;

  Urls({required this.full, required this.raw});

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(full: json['full'], raw: json['raw']);
  }
}

class User {
  final String name;

  User({required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name']);
  }
}

Future<UnsplashPhotosList> getUnsplashPhotos() async {
  const url =
      'https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return UnsplashPhotosList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error: ${response.statusCode}');
  }
}
