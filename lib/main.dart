import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/country_provider.dart';
import 'package:task/Screens/homescreen.dart';
 

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
       create: (context) => CountryProvider(),
      child: MaterialApp(
        title: 'Flutter Task',
        theme: ThemeData(
          
          
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  ContinentListScreen(),
      ),
    );
  }
}

