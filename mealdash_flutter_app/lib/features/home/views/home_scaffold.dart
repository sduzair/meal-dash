import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class HomeScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;
  const HomeScaffoldWithBottomNav({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatefulShellRouteState shellState = StatefulShellRoute.of(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
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
        currentIndex: shellState.index,
        onTap: (index) {
          shellState.goBranch(index);
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              // onTap: () =>
              //     GoRouter.of(context).goNamed(constants.profileRouteName),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
              // onTap: () =>
              //     GoRouter.of(context).goNamed(constants.messagesRouteName),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              // onTap: () =>
              //     GoRouter.of(context).goNamed(constants.settingsRouteName),
            ),
          ),
        ],
      ),
    );
  }
}

// class HomeDrawer extends StatelessWidget {
//   const HomeDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: const <Widget>[
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: constants.kPrimaryColor,
//             ),
//             child: Text(
//               'Drawer Header',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.message),
//             title: Text('Messages'),
//           ),
//           ListTile(
//             leading: Icon(Icons.account_circle),
//             title: Text('Profile'),
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//           ),
//         ],
//       ),
//     );
//   }
// }
