import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:house_rental_app/main.dart';
import 'package:house_rental_app/viewProperties.dart';
import 'package:http/http.dart' as http;


class HouseSearchPage extends StatefulWidget {
  const HouseSearchPage({super.key});

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
  late Map<String, dynamic> data;
  Future search(String locationQuery, int rentBudget, List<String> amenitiesList) async{
    
    try{
      String uri = 'http://localhost:3000/search';
      
      var res = await http.post(Uri.parse(uri), body: {
          "location": locationQuery,
          "rent": rentBudget.toString(),
          "amenitiesList": jsonEncode(amenities),
        });

        data = jsonDecode(res.body);
        
        return data;
    }
    catch(e){
      print(e);
    }
  }

  Widget buildSearchFilterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location search field
          TextField(
            decoration: const InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                locationQuery = value;
              });
            },
          ),
          const SizedBox(height: 16),

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
          const SizedBox(height: 16),

          // Amenities checkboxes
          const Text('Amenities'),
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
        title: const Text('House Rental Search'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSearchFilterWidget(context),

            ElevatedButton(
              onPressed: () async {
                await search(locationQuery, rentBudget, amenities);
                //print(data['results']);
              
                Navigator.push(context, MaterialPageRoute(builder: (context) => viewProperties(data: data)));
              },
              child: const Text('Search',
              ),
            ),
          ],
        ),
      ),
    );
  }
}