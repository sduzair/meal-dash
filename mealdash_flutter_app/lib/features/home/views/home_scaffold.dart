import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

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
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
        actions: const [
          LogoutButton(),
        ],
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

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authVMWatch = context.watch<UserAuthViewModel>();
    if (authVMWatch.isLoggingOutSuccess) {
      // * LOGGINGIN STATE IN USERAUTHVIEWMODEL COULD NOT BE RESET HERE IT INTERFERED WITH ROUTING WHICH IS ALSO BASED ON USERAUTHVIEWMODEL
      // context.read<UserAuthViewModel>().resetLoginStateAndNotifyListeners();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).goNamed(constants.loginRouteName);
      });
    } else if (authVMWatch.isLoggingOutError) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).clearMaterialBanners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authVMWatch.logoutErrorMessage!),
          ),
        );
      });
    }
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        // THIS HIDES THE SNACKBAR THAT SAYS LOGIN SUCCESSFUL IF IT IS VISIBLE, THIS MEANS USER IS LOGGING OUT QUICKLY AFTER LOGGING IN AND THE SNACKBAR IS STILL VISIBLE FROM THE LOGIN
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        // logout using UserAuthViewModel and navigate to login screen
        context.read<UserAuthViewModel>().logout();
      },
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
