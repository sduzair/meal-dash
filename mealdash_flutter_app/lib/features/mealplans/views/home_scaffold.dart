import 'package:go_router/go_router.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:flutter/material.dart';

class HomeScaffoldWithBottomNav extends StatefulWidget {
  final Widget child;
  const HomeScaffoldWithBottomNav({Key? key, required this.child})
      : super(key: key);

  @override
  State<HomeScaffoldWithBottomNav> createState() =>
      _HomeScaffoldWithBottomNavState();
}

class _HomeScaffoldWithBottomNavState extends State<HomeScaffoldWithBottomNav> {
  int get _selectedIndex {
    var indexWhere = constants.HomeNavTabRouteNames.values.indexWhere(
        (element) => '/${element.name}' == GoRouter.of(context).location);
    // print('indexWhere: $indexWhere');
    return indexWhere;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      appBar: AppBar(
        // leading: const Icon(Icons.menu),
        title: const Text('Home'),
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
        onTap: (index) {
          _selectedIndex != index
              ? context
                  .goNamed(constants.HomeNavTabRouteNames.values[index].name)
              : null;
        },
      ),
    );
  }
}
