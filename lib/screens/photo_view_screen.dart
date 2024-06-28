import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String photoUrl = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Просмотр фотографии'),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: photoUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
