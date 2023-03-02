import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HouseSearchPage extends StatefulWidget {
  @override
  _HouseSearchPageState createState() => _HouseSearchPageState();
}

class _HouseSearchPageState extends State<HouseSearchPage> {
  
  String locationQuery = '';
  int rentBudget = 0;
  List<String> amenities = [];

  // Define list of available amenities
  List<String> availableAmenities = [
    'Gym',
    'Swimming Pool',
    'Parking',
    'Pet-friendly',
    'Furnished',
  ];

  Future search(String locationQuery, int rentBudget, List<String> amenitiesList) async{
    print(locationQuery);
    try{
      String uri = 'http://localhost:3000/search';
      
      var res = await http.post(Uri.parse(uri), body: {
          "location": locationQuery,
          "rent": rentBudget.toString(),
          "amenitiesList": jsonEncode(amenities),
        });

        var response = jsonDecode(res.body);
      print(response['success']);
      print(response['results']);

    }
    catch(e){
      print(e);
    }
  }



  // Build search filter widget
  Widget buildSearchFilterWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location search field
          TextField(
            decoration: InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                locationQuery = value;
              });
            },
          ),
          SizedBox(height: 16),

          // Rent budget slider
          Text('Rent Budget: \$${rentBudget.toString()}'),
          Slider(
            min: 0,
            max: 20000,
            divisions: 10,
            value: rentBudget.toDouble(),
            onChanged: (double value) {
              setState(() {
                rentBudget = value.toInt();
              });
            },
          ),
          SizedBox(height: 16),

          // Amenities checkboxes
          Text('Amenities'),
          Wrap(
            spacing: 8,
            children: availableAmenities.map((amenity) {
              return FilterChip(
                label: Text(amenity),
                selected: amenities.contains(amenity),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      amenities.add(amenity);
                    } else {
                      amenities.remove(amenity);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House Rental Search'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSearchFilterWidget(context),

            // Search button
            ElevatedButton(
              onPressed: () {
                // Perform search with selected filters
                
                print('Performing search with filters:');
                print('Location: $locationQuery');
                print('Rent Budget: $rentBudget');
                print('Amenities: $amenities');

                search(locationQuery, rentBudget, amenities);
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
