import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_rental_app/HouseSearchPage.dart';



class TenantHomePage extends StatefulWidget {
  @override
  _TenantHomePageState createState() => _TenantHomePageState();
}

class _TenantHomePageState extends State<TenantHomePage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[MyHome(),  UserProfile(),  HouseSearchPage(),       Chat(),    Notifications(),  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.black,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.black,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Colors.black,
            
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade50,
        onTap: _onItemTapped,
        
      ),
    );
  }
}

class MyHome extends StatelessWidget {

  List<String> imageNames = ['images/1.jpg', 'images/2.jpg', 'images/3.webp', 'images/4.webp'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
              ),
              
              Text('\tHyderabad, India'),
              Spacer(),
              Padding(padding: EdgeInsets.all(12.0),
              child: Icon(Icons.notifications_sharp,
              size: 30),
              )
              
            ],
            
          ),

          Text('\n\nHello, username\n'),

          const Text(
            'Find your best rental home',
            style: TextStyle(
              fontFamily: "TiltNeon-Regular",
              fontSize: 25),
              ),
          
      
                  
                Container(
            height: 34,
            width: 400,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
            
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            
            boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: const TextField(
        
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
        ),
      ),),
          
          

            const Text(
            '\nCategories\n',
             style: TextStyle(
              fontSize: 16,
              fontFamily: "TiltNeon-Regular",
              fontWeight: FontWeight.bold,
             ),
             ),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children:[
          
          Padding(
            padding: EdgeInsets.all(6.0),
            child: ElevatedButton(onPressed: (){
          }, 
          child: const Text('House'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade100),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ))
          ),
          ),),
          
          
          Padding(
            padding: EdgeInsets.all(6.0),
            child: ElevatedButton(onPressed: (){
          }, 
          
          child: const Text('Bunglow'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade100),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ))
          ),
          ),),

          
          Padding(
            padding: EdgeInsets.all(6.0),
            child: ElevatedButton(onPressed: (){
          }, 
          
          child: const Text('Flat'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade100),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ))
          ),
          ),),
          ],
          ),

          const Text(
            '\n\nNearby Places',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "TiltNeon-Regular",
              fontWeight: FontWeight.bold,
              
             ),
            ),


      Container(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(18.0),
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
        
        ],
          
        ),
      );
  }
}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'User Profile',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Chat',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Notifications',
          style: TextStyle(fontSize: 30,
          backgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
