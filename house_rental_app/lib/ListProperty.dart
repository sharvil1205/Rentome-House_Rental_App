import 'dart:convert';
import 'package:house_rental_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:house_rental_app/ManageProperty.dart';

class ListProperty extends StatefulWidget {
  const ListProperty({super.key});

  @override
  State<ListProperty> createState() => _ListPropertyState();
}

class _ListPropertyState extends State<ListProperty> {

  String locationQuery = '';
  int rentBudget = 0;
  int pSize = 0;
  List<String> amenities = [];

  // Define list of available amenities
  List<String> availableAmenities = [
    'Gym',
    'Swimming Pool',
    'Parking',
    'Pet-friendly',
    'Furnished',
  ];
  
  Future list(String locationQuery, int rentBudget, int size, List<String> amenitiesList) async{
    print(locationQuery);
    print(rentBudget);
    print(amenitiesList);
    try{
      String uri = 'http://localhost:3000/list';
      
      var res = await http.post(Uri.parse(uri), body: {
          "location": locationQuery,
          "rent": rentBudget.toString(),
          "size": size.toString(),
          "amenitiesList": jsonEncode(amenities).toString(),
          "uname": uname,
        });
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

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

            TextField(
            decoration: const InputDecoration(
              labelText: 'Rent',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                rentBudget = int.parse(value);
              });
            },
          ),

            TextField(
            decoration: const InputDecoration(
              labelText: 'Size',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                pSize = int.parse(value);
              });
            },
          ),


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

          ElevatedButton(
              onPressed: () async {
                await list(locationQuery, rentBudget, pSize, amenities);
              
                Navigator.push(context, MaterialPageRoute(builder: (context) => ManageProperty()));
              },
              child: const Text('Add',
              ),
            ),

        ],
      ),
    );
  }
}