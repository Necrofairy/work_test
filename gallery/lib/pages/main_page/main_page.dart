import 'package:flutter/material.dart';

import '../../json/unsplash_photos.dart';
import '../photo_page/photo_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<UnsplashPhotosList>? photos;

  @override
  void initState() {
    super.initState();
    photos = getUnsplashPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UnsplashPhotosList>(
        future: photos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.photos.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Name:${snapshot.data?.photos[index].name.name}'),
                      subtitle: Text('id:${snapshot.data?.photos[index].id}'),
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhotoPage(
                                        photoName:
                                            '${snapshot.data?.photos[index].urls.full}',
                                      )));
                        },
                        child: Image.network(
                          '${snapshot.data?.photos[index].urls.full}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Text('Error!');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
