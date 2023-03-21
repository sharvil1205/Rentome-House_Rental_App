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
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
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
        TextField(
          decoration: InputDecoration(
            labelText: 'Rent',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              rentBudget = int.parse(value);
            });
          },
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Size',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              pSize = int.parse(value);
            });
          },
        ),
        const SizedBox(height: 32),
        const Text(
          'Amenities',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 32),
        
        SizedBox(
          height: 30,
          width: 400,
          child: ElevatedButton(
          onPressed: () async {
            await list(locationQuery, rentBudget, pSize, amenities);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManageProperty()),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.purple.shade600),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),),
            ),
            ),
          child: const Text(
            'Add',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ),
        
      ],
    ),
  ),
);

  }
}