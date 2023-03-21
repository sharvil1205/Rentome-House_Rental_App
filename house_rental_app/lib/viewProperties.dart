import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:house_rental_app/viewPropertyDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class viewProperties extends StatefulWidget {
  final Map<String, dynamic> data;
  final List<LatLng> locations;
  final double lat;
  final double long;
  
  const viewProperties({Key?key, required this.data, required this.locations, required this.lat, required this.long}) : super(key: key);


  @override
  State<viewProperties> createState() => _viewPropertiesState();
}

class _viewPropertiesState extends State<viewProperties> {
    
    List<dynamic> list = [];

    Future<List<List<dynamic>>> _fetchAmenities() async {
  const endpoint = 'https://overpass-api.de/api/interpreter?data=[out:json][timeout:25];';
  final categories = {
    'Entertainment': '"amenity"~%27nightclub|cinema|theatre',
    'Transportation': '"amenity"~%27bus_station|taxi|fuel',
    'Eateries': '"amenity"~%27restaurant|fast_food|cafe|pub|bar',
    'Healthcare': '"amenity"~%27hospital|doctors|pharmacy',
    'Finance': '"amenity"~%27bank|atm',
    'Emergency': '"amenity"~%27fire_station|police'
  };
  final categoryNames = categories.keys.toList();

  final futures = <Future>[];
  for (var category in categories.keys) {
    final query = endpoint +
        '(node[' + '${categories[category]}' + '%27](around:3000,${widget.lat},${widget.long}););out 5;';
    print(query);

    futures.add(http.get(Uri.parse(query)).then((response) {
      if (response.statusCode == 200) {
        final data1 = jsonDecode(response.body);
        final elements = data1['elements'];
        List<dynamic> ls = [];
        for (var v in elements) {
          print(v['tags']['name']);
          if (v['tags']['name'] != null) ls.add(v['tags']);
        }
        return ls;
      } else {
        return null;
      }
    }));
  }

  final amenities = await Future.wait(futures);

  final result = <List<dynamic>>[];
  for (var i = 0; i < categoryNames.length; i++) {
    if (amenities[i] != null) {
      result.add(amenities[i]);
    }
  }

  return result;
}

  final MapController _mapController = MapController();
  late LatLng _currentLocation;
  late List<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _markers = [];
    _getCurrentLocation();
  }

   Future<void> _getCurrentLocation() async {
    setState(() {
      _currentLocation = LatLng(widget.lat, widget.long);
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: _currentLocation,
          builder: (ctx) => const Icon(
            Icons.location_pin,
            color: Colors.black,),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
      children: [ 
        SizedBox(
          height: 300,
          child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
          center: _currentLocation,
          zoom: 13.0,
        ),
         children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: widget.locations
                      .map((LatLng latlng) => Marker(
                        height: 50,
                        width: 100,
                      point: latlng,
                      builder: (ctx) => Column(
                        children:  [
                          Icon(Icons.location_pin,
                            color: Colors.red,),
                            Text('hi', style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),),
                            ])
                    ))
                .toList(),
          ),
        ],
        ),
        ),
      
      SizedBox(
  height: 400,
  child: ListView.builder(
    itemCount: widget.data['results'].length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () async {
          List<dynamic> ls1 = await _fetchAmenities();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => viewPropertyDetails(
                data: widget.data,
                index: index,
                list: ls1,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.data['results'][index]['location'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rent: ${widget.data['results'][index]['rent']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Amenities: ${widget.data['results'][index]['amenities']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
),
    ]  
      )
    );  
  }
}