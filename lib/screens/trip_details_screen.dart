import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/trip.dart';

class TripDetailsScreen extends StatelessWidget {
  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    final Trip trip = ModalRoute.of(context)!.settings.arguments as Trip;

    TextStyle titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle contentStyle = TextStyle(fontSize: 16);

    return Scaffold(
      appBar: AppBar(
        title: Text(trip.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Дата поездки:',
                    style: titleStyle,
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatDate(trip.date),
                    style: contentStyle,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Описание поездки:',
                    style: titleStyle,
                  ),
                  SizedBox(height: 4),
                  Text(
                    trip.description,
                    style: contentStyle,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/photoView', arguments: trip.photoUrl);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: trip.photoUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
