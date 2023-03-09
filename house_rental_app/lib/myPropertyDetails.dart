import 'package:flutter/material.dart';

class myPropertyDetails extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;

  const myPropertyDetails({Key?key, required this.data, required this.index}) : super(key: key);

  @override
  State<myPropertyDetails> createState() => _myPropertyDetailsState();
}

class _myPropertyDetailsState extends State<myPropertyDetails> {

  List<String> imageNames = ['images/1.jpg', 'images/2.jpg', 'images/3.webp', 'images/4.webp'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    Container(
      child: Column(
        children: [
          const SizedBox(height: 16.0),

          Container(
               child: 
               const Text(
                'My Property',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                fontFamily: "TiltNeon-Regular",
                height: 5)),   
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
      
    SizedBox(

      height: 30,
            width: 400,
            child: ElevatedButton(
            onPressed: (){},
          
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.purple.shade600),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),),
            ),
            ),
            child: const Text(
              'Edit',
              style: TextStyle(
                fontWeight: FontWeight.bold),
            ),
            ),
          )
        ],
      ),
    ),
    );
  }
}