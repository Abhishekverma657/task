import 'package:flutter/material.dart';

class CountryDetailsScreen extends StatelessWidget {
  final dynamic country;

  const CountryDetailsScreen({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country['name']['common']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Region: ${country['region']}'),
            Text('Subregion: ${country['subregion']}'),
            Text('Population: ${country['population']}'),
             Text("capital:${country['capital'][0]}")

            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
