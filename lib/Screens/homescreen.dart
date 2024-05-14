 


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Providers/country_provider.dart';
import 'package:task/Screens/Details.dart';

class ContinentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Continents List'),
      ),
      body: Consumer<CountryProvider>(
        builder: (context, countryProvider, _) {
          if (countryProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (countryProvider.hasError) {
            return Center(child: Text('Failed to load data'));
          } else {
          return ListView.builder(
            itemCount: countryProvider.continents.length,
            itemBuilder: (context, index) {
              String continent = countryProvider.continents[index];
              bool isExpanded = countryProvider.filteredCountriesByContinent[continent] != null;

              return Container(
                
                margin: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   color: Colors.white,
                    boxShadow: const  [
                BoxShadow(
                  color: Colors.redAccent,
                  offset: Offset(0, 10),
                  blurRadius: 3,
                  spreadRadius: -10)
              ],
                   borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red)),
                child: ExpansionTile(
                  title: Text(continent),
                  initiallyExpanded: false,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          decoration:  const InputDecoration(
                             border: InputBorder.none,
                             contentPadding: EdgeInsets.zero,
                            labelText: 'Search countries',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            countryProvider.filterCountries(value, continent);
                          },
                        ),
                      ),
                    ),
                    if (isExpanded)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: countryProvider.filteredCountriesByContinent[continent]!.length,
                        itemBuilder: (context, index) {
                          var country = countryProvider.filteredCountriesByContinent[continent]![index];
                          return GestureDetector(
                            onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountryDetailsScreen(country: country),
                      ),
                    );
                  },
                            child: Container(
                              margin: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black38)),
                              child: ListTile(
                                
                                leading:  Container(
                                   height: 20,
                                    width: 40,
                                   decoration: BoxDecoration(
                                   shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                     fit: BoxFit.cover,
                                    image: NetworkImage(country['flags']['png']))
                                ),),
                               
                                
                                title: Text(country['name']['common']),
                                subtitle: Text(country['capital'][0]),
                                trailing: Column(children: [
                                   Text("Population"),
                                   Text(country['population'].toString())
                                ],),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          );
          }
        },
      ),
    );
  }
}