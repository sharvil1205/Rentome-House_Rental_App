import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class TenantHomePage extends StatefulWidget {
  @override
  _TenantHomePageState createState() => _TenantHomePageState();
}

class _TenantHomePageState extends State<TenantHomePage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[    SearchProperties(),    UserProfile(),    Chat(),    Notifications(),  ];

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
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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

class SearchProperties extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_city,
              ),
              
              Text('\tHyderabad, India'),
            ],
          ),

          Text('\n\nHello, username'),

          Text(
            '\nFind your best rental home\n',
            style: TextStyle(
              fontFamily: "TiltNeon-Regular",
              fontSize: 25),
              ),
          Flexible(
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
              ),
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14
              ),

              prefixIcon: Container(
                          padding: EdgeInsets.all(15),
                          child: Image.asset('images/search.png'),
                          width: 18,
                        )

              ),
              
            ),
            ),

            const Text(
            '\n\n\nCategories \n',
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
          Spacer(),
          ElevatedButton(onPressed: (){
          }, 
          child: const Text('House'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ))
          ),
          
          ),
          Spacer(),
          
          ElevatedButton(onPressed: (){
          }, 
          child: const Text('Bunglow'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ))
          ),
          ),
          Spacer(),
          
          ElevatedButton(onPressed: (){
          }, 
          child: const Text('Flat'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ))
          ),
          ),
          Spacer(),
          ],
          ),

          Text(
            '\n\n\nNearby Places\n',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "TiltNeon-Regular",
              fontWeight: FontWeight.bold,
              
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
