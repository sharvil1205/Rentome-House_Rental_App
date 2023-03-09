import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:house_rental_app/viewPropertyDetails.dart';

class viewProperties extends StatefulWidget {
  final Map<String, dynamic> data;
  
  const viewProperties({Key?key, required this.data}) : super(key: key);

  @override
  State<viewProperties> createState() => _viewPropertiesState();
}

class _viewPropertiesState extends State<viewProperties> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Properties'),      
      ),

      body: ListView.builder(
        itemCount: widget.data['results'].length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => viewPropertyDetails(data: widget.data, index: index,))),
            child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.house),
                  title: Text(widget.data['results'][index]['location']),
                  subtitle: Text('Rent: ${widget.data['results'][index]['rent']}, Amenities: ${widget.data['results'][index]['amenities']}'),
                ),
              ],
            ),
          )
          );
        },
      ),
    );
  }
}