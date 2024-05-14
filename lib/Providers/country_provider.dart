// // import 'package:flutter/foundation.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // import 'package:task/Models/country_model.dart';
// // import 'package:task/service/apiService.dart';

// // class MyProvider extends ChangeNotifier {
// //    ApiService _service=ApiService();
// //   List<continentsModel> _continents = [];
// //   //  List<dynamic> continents = [];
// //   Map<String, List<dynamic>> countriesByContinent = {};
// //   Map<String, List<dynamic>> filteredCountriesByContinent = {};
// //   bool isloding =false;


// //   List<continentsModel> get continents => _continents;

// //   Future<void> loadContinents() async {
// //     try {
// //        isloding=true;
// //         notifyListeners();
// //       _continents = await _service. fetchContinents();
// //         isloding=false;
// //       notifyListeners();
// //     } catch (e) {
// //       print('Error: $e');
// //       //  print();
// //     }
// //   }
// // }

// // // Future<List<continentsModel>> fetchContinents() async {
// // //   final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
// // //   if (response.statusCode == 200) {
// // //     List<dynamic> data = json.decode(response.body);
// // //      List<continentsModel> continents = data.map((json) => continentsModel.fromJson(json)).toList();
// // //       print(continents); 
// // //     return data.map((json) => continentsModel.fromJson(json)).toList();
// // //   } else {
// // //     throw Exception('Failed to load continents');
// // //   }
// // // }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class CountryProvider extends ChangeNotifier {
//   List<dynamic> continents = [];
//   Map<String, List<dynamic>> countriesByContinent = {};
//   Map<String, List<dynamic>> filteredCountriesByContinent = {};

//   CountryProvider() {
//     fetchContinents();
//   }

//   Future<void> fetchContinents() async {
//     final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
//     if (response.statusCode == 200) {
//       List<dynamic> countries = json.decode(response.body);

//       countriesByContinent = {};
//       for (var country in countries) {
//         String continent = country['region'];
//         if (!countriesByContinent.containsKey(continent)) {
//           countriesByContinent[continent] = [];
//         }
//         countriesByContinent[continent]!.add(country);
//       }

//       continents = countriesByContinent.keys.toList();
//       filteredCountriesByContinent = countriesByContinent;
//       notifyListeners();
//     } else {
//       throw Exception('Failed to load continents');
//     }
//   }

//   void filterCountries(String query, String continent) {
//     if (query.isEmpty) {
//       filteredCountriesByContinent[continent] = countriesByContinent[continent]!;
//     } else {
//       filteredCountriesByContinent[continent] = countriesByContinent[continent]!.where((country) {
//         String name = country['name']['common'];
//         return name.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     }
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryProvider extends ChangeNotifier {
  List<String> continents = [];
  Map<String, List<dynamic>> countriesByContinent = {};
  Map<String, List<dynamic>> filteredCountriesByContinent = {};
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  CountryProvider() {
    fetchContinents();
  }

  Future<void> fetchContinents() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
      if (response.statusCode == 200) {
        List<dynamic> countries = json.decode(response.body);

        countriesByContinent = {};
        for (var country in countries) {
          String continent = country['region'];
          if (!countriesByContinent.containsKey(continent)) {
            countriesByContinent[continent] = [];
          }
          countriesByContinent[continent]!.add(country);
        }

        continents = countriesByContinent.keys.toList();
        filteredCountriesByContinent = countriesByContinent;
      } else {
        hasError = true;
        errorMessage = 'Failed to load continents';
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'Error: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  void filterCountries(String query, String continent) {
    if (query.isEmpty) {
      filteredCountriesByContinent[continent] = countriesByContinent[continent]!;
    } else {
      filteredCountriesByContinent[continent] = countriesByContinent[continent]!.where((country) {
        String name = country['name']['common'];
        return name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
