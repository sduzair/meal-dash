import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:flutter/material.dart';

class FoodVendorHome extends StatefulWidget {
  const FoodVendorHome({Key? key}) : super(key: key);

  @override
  State<FoodVendorHome> createState() => _FoodVendorHomeState();
}

class _FoodVendorHomeState extends State<FoodVendorHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Orders',
      style: optionStyle,
    ),
    Text(
      'Meal Plans',
      style: optionStyle,
    ),
    Text(
      'Meals',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.menu),
        title: const Text('Menu'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: constants.kPrimaryColor,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Meal Plans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dining_rounded),
            label: 'Meals',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: constants.kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
