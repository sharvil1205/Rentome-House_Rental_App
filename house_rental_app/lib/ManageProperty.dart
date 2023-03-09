import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rental_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:house_rental_app/ListProperty.dart';
import 'package:house_rental_app/viewProperty.dart';
import 'package:house_rental_app/TrackRentalRequests.dart';

class ManageProperty extends StatefulWidget {
  const ManageProperty({super.key});

  @override
  State<ManageProperty> createState() => _ManagePropertyState();
}

class _ManagePropertyState extends State<ManageProperty> {
late Map<String, dynamic> data;
late Map<String, dynamic> data1;
  Future propList() async{
    try{
      String uri = 'http://localhost:3000/propList';
      
      var res = await http.post(Uri.parse(uri), body: {
          "uname": uname,
        });

        data = jsonDecode(res.body);
        return data;
    }
    catch(e){
      print(e);
    }
  }

  Future track() async{
    try{
      String uri = 'http://localhost:3000/track';
      
      var res = await http.post(Uri.parse(uri), body: {
          "landlordUsername": uname,
        });

        data1 = jsonDecode(res.body);       
        return data1;
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
          ElevatedButton(
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ListProperty()));
          print(uname);
          }, 
          child: const Text("List Property")
          ),
          
          ElevatedButton(
          onPressed:  () async{
            await propList();
            Navigator.push(context, MaterialPageRoute(builder: (context) => viewProperty(data: data)));
          }, 
          child: const Text("View Property")
          ),

          ElevatedButton(
          onPressed: () async{
            await track();
            Navigator.push(context, MaterialPageRoute(builder: (context) => TrackRentalRequests(data1: data1)));
          }, 
          child: const Text("Track Rental Requests")
          ),

          ElevatedButton(
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ListProperty()));
          print(uname);}, 
          child: const Text("Address Complaints")
          ),

        ],
      ),
    );
  }
}