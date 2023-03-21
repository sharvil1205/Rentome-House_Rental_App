import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rental_app/main.dart';
import 'package:http/http.dart' as http;

class viewPropertyDetails extends StatefulWidget {
  
  final Map<String, dynamic> data;
  final int index;
  final List<dynamic> list;
  const viewPropertyDetails({Key?key, required this.data, required this.index, required this.list}) : super(key: key);

  @override
  State<viewPropertyDetails> createState() => _viewPropertyDetailsState();
}

class _viewPropertyDetailsState extends State<viewPropertyDetails> {
  final Map<String, bool> _isExpanded = {
    'Entertainment': false,
    'Transportation': false,
    'Eateries': false,
    'Healthcare': false,
    'Financial': false,
    'Emergency': false,
  };
  
  Future apply() async {
    try{
      String uri = 'http://localhost:3000/apply';
        print(widget.data);
        var res = await http.post(Uri.parse(uri), body: {
          "tenantUsername": uname,
          "propertyID": widget.data['results'][widget.index]['propertyID'].toString(),
          "landlordUsername": widget.data['results'][widget.index]['username']
        });
        var response = jsonDecode(res.body);
    }
    catch(e){
      print(e);
    }
  }

  List<String> imageNames = ['images/1.jpg', 'images/2.jpg', 'images/3.webp', 'images/4.webp'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          
          Container(
               child: 
               const Text(
                'Property Details',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                fontFamily: "TiltNeon-Regular",
                height: 2)),   
            ),
            
          const SizedBox(height: 16.0),
          
          Text(
              'Property ID: ${widget.data['results'][widget.index]['propertyID']}',
              style: const TextStyle(
                fontSize: 18.0, 
                fontWeight: FontWeight.bold,
                fontFamily: "TiltNeon-Regular"),
            ),
            
            const SizedBox(height: 16.0),
            
            Text(
              'Location: ${widget.data['results'][widget.index]['location']}',
              style: const TextStyle(
                fontSize: 18.0, 
                fontWeight: FontWeight.bold,
                fontFamily: "TiltNeon-Regular"),
            ),
            
            const SizedBox(height: 16.0),
            
            Text(
              'Rent: ${widget.data['results'][widget.index]['rent']}',
              style: const TextStyle(
                fontSize: 18.0, 
                fontWeight: FontWeight.bold,
                fontFamily: "TiltNeon-Regular"),
            ),
            
            const SizedBox(height: 16.0),
            
            Text(
              'Size: ${widget.data['results'][widget.index]['size']}',
              style: const TextStyle(
                fontSize: 18.0, 
                fontWeight: FontWeight.bold,
                fontFamily: "TiltNeon-Regular"),
            ),

            const SizedBox(height: 16.0),
            
            Text(
              'Amenities: ${widget.data['results'][widget.index]['amenities']}',
              style: const TextStyle(
                fontSize: 18.0, 
                fontWeight: FontWeight.bold,
                fontFamily: "TiltNeon-Regular",
                color: Colors.black),
            ),  
              
              Container(
                height: 200.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        imageNames[index],
                        fit: BoxFit.cover,
                        width: 180.0,
                        height: 200.0,
                      ),
                        ),
                      ); 
                    },
                  ),
                ),
                
                const SizedBox(height: 30,),
                const SizedBox(
                  child: Text(
                'Things to do nearby: ',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "TiltNeon-Regular",
                height: 2)),
                ),

                const SizedBox(height: 15,),
              _buildExpansionList('Entertainment', widget.list[0]),
              _buildExpansionList('Transportation', widget.list[1]),
              _buildExpansionList('Eateries', widget.list[2]),
              _buildExpansionList('Healthcare', widget.list[3]),
              _buildExpansionList('Financial', widget.list[4]),
              _buildExpansionList('Emergency', widget.list[5]),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
                width: 400,
                child: ElevatedButton(
                onPressed: apply,
          
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple.shade600),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),),
              ),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  fontWeight: FontWeight.bold),
              ),
              ),
              ),
              
              SizedBox(height: 30,),
        ],
      ),
    
    ),
    );
  }
  Widget _buildExpansionList(String title, List<dynamic> items) {
  return Theme(
    data: ThemeData(
      accentColor: Colors.black,
      dividerColor: Colors.transparent,
    ),
    child: ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 500),
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isExpanded[title] = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: "TiltNeon-Regular",
                  color: isExpanded ? Colors.black : Colors.grey,
                ),
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(
                      items[index]['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      items[index]['amenity'],
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          isExpanded: _isExpanded[title]!,
        ),
      ],
    ),
  );
}

}