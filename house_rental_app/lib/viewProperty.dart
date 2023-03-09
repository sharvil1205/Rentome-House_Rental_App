import 'package:flutter/material.dart';
import 'package:house_rental_app/myPropertyDetails.dart';

class viewProperty extends StatefulWidget {
  final Map<String, dynamic> data;

  const viewProperty({Key?key, required this.data}) : super(key: key);

  @override
  State<viewProperty> createState() => _viewPropertyState();
}

class _viewPropertyState extends State<viewProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Properties'),      
      ),

      body: ListView.builder(
        itemCount: widget.data['results'].length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => myPropertyDetails(data: widget.data, index: index,))),
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