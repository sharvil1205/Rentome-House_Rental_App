import 'package:flutter/material.dart';
import 'package:house_rental_app/AcceptRejectRequest.dart';

class TrackRentalRequests extends StatefulWidget {
  final Map<String, dynamic> data1;
  const TrackRentalRequests({Key?key, required this.data1}) : super(key: key);

  @override
  State<TrackRentalRequests> createState() => _TrackRentalRequestsState();
}

class _TrackRentalRequestsState extends State<TrackRentalRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rental Requests'),      
      ),

      body: ListView.builder(
        itemCount: widget.data1['results'].length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AcceptRejectRequest(data: widget.data1, index: index))),
            child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.house),
                  title: Text(widget.data1['results'][index]['tenantUsername']),
                  subtitle: Text('Application ID: ${widget.data1['results'][index]['applicationID']}, PropertyID: ${widget.data1['results'][index]['propertyID']}'),
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