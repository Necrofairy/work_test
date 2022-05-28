import 'package:flutter/material.dart';

class PhotoPage extends StatelessWidget {
  final String photoName;

  const PhotoPage({Key? key, required this.photoName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(child: Image.network(photoName));
  }
}
