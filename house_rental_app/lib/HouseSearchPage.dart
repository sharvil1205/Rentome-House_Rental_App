import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:house_rental_app/viewProperties.dart';


class HouseSearchPage extends StatefulWidget {
  const HouseSearchPage({super.key});

  @override
  _HouseSearchPageState createState() => _HouseSearchPageState();
}

class _HouseSearchPageState extends State<HouseSearchPage> {
  
  List<LatLng> locations = [];
  late Map<String, dynamic> d;
  TextEditingController radiusController = TextEditingController();
  String address = '';
  int rentBudget = 0;
  double lat = 0;
  double long = 0;

  Future search() async{
    String uri = 'http://localhost:3000/properties';
    
    try{
      var res = await http.post(Uri.parse(uri), body: {
        "location": address,
        "radius": radiusController.text,
        "rent": rentBudget.toString(),
        "latitude": lat.toString(),
        "longitude": long.toString(),
        "city": "Pune"
      });
      d = jsonDecode(res.body);
      List<dynamic> data = d['results'];
    
      print(data);

      for (var item in data) {
      final lat = double.parse(item['latitude'].toString());
      final lng = double.parse(item['longitude'].toString());
      locations.add(LatLng(lat, lng));
    }
    print(locations);
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Center(child: Text(address)),
          ),
          SizedBox(
            height: 500,
            child: OpenStreetMapSearchAndPick(center: LatLong(18.515854, 73.807765), 
            onPicked: (pickedData){
              setState(() {
                address = pickedData.address;
                lat = pickedData.latLong.latitude;
                long = pickedData.latLong.longitude;
              });
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);
            }),
          ),
          SizedBox(
            height: 100,
            child: Center(child: TextField(
              controller: radiusController,
              decoration: const InputDecoration(
                hintText: 'Radius',
              ),
            )),
          ),

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

          ElevatedButton(onPressed: () async {
            
            await search();
            
            Navigator.push(context, MaterialPageRoute(builder: (context) => viewProperties(data: d, locations: locations, lat: lat, long: long,)));}, 
          child: const Text('Search')),
        ],
      ),
      )
      
    );
  }
}