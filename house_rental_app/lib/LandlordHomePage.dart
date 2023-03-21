import 'package:flutter/material.dart';
import 'package:house_rental_app/ListProperty.dart';
import 'package:house_rental_app/ManageProperty.dart';
import 'package:house_rental_app/LandlordProfile.dart';

class LandlordHomePage extends StatefulWidget {
  @override
  _LandlordHomePageState createState() => _LandlordHomePageState();
}

class _LandlordHomePageState extends State<LandlordHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[const LandlordProfile(),  const ManageProperty(),    const ListProperty(), const Notifications(),  ];

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
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.black,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Manage Property',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_rounded),
            label: 'List Property',
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


class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          'Notifications',
          style: TextStyle(fontSize: 30,
          
          ),
        ),
      ),
    );
  }
}