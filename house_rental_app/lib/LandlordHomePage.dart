import 'package:flutter/material.dart';
import 'package:house_rental_app/ManageProperty.dart';

class LandlordHomePage extends StatefulWidget {
  @override
  _LandlordHomePageState createState() => _LandlordHomePageState();
}

class _LandlordHomePageState extends State<LandlordHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[LandlordProfile(),  ManageProperty(),    Chat(), Notifications(),  ];

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
            icon: Icon(Icons.message),
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

class LandlordProfile extends StatelessWidget {
  const LandlordProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          'Landlord Profile',
          style: TextStyle(fontSize: 30,
          
          ),
        ),
      ),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          'Chat',
          style: TextStyle(fontSize: 30,
          
          ),
        ),
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