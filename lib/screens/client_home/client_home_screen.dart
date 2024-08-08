import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';



import '../../services/listing_service.dart';
import '../../services/properties_service.dart';
import '../profile/profile_screen.dart';
import 'components/body.dart';

// class ClientHomeScreen extends StatefulWidget {
//   static String routeName = '/client';
//   const ClientHomeScreen({super.key});

//   @override
//   State<ClientHomeScreen> createState() => _ClientHomeScreenState();
// }

// class _ClientHomeScreenState extends State<ClientHomeScreen> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   int _selectedIndex = 2;

//   static final List<Widget> _pages = <Widget>[
//     const SearchScreen(),
//     const FavoritesScreen(),
//     const Body(),
//     const NotificationsScreen(),
//     const ProfileScreen(),
//   ];

//   static final List<Widget> _bottomBarIcons = <Widget>[
//     const Icon(Icons.map_outlined),
//     const Icon(Icons.favorite),
//     const Icon(Icons.home),
//     const Icon(Icons.notifications),
//     const Icon(Icons.person),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         body: _pages[_selectedIndex],
//         extendBody: true,
//         bottomNavigationBar: CurvedNavigationBar(
//           items: _bottomBarIcons,
//           index: _selectedIndex,
//           height: 50.0,
//           color: Theme.of(context).primaryColor,
//           backgroundColor: Colors.transparent,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../welcome/welcome_screen.dart';
import 'components/body.dart';

class ClientHomeScreen extends StatefulWidget {
  static String routeName = '/client';
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 2;

  static final List<Widget> _pages = <Widget>[
    const SearchScreen(),
    const FavoritesScreen(),
    const Body(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  static final List<Widget> _bottomBarIcons = <Widget>[
    const Icon(Icons.map_outlined),
    const Icon(Icons.favorite),
    const Icon(Icons.home),
    const Icon(Icons.notifications),
    const Icon(Icons.person),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isAuthenticated) {
      Future.microtask(() {
        Navigator.pushNamedAndRemoveUntil(
          context,
          WelcomeScreen.routeName,
          (Route<dynamic> route) => false,
        );
      });
      return const SizedBox.shrink();
    }

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: _pages[_selectedIndex],
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          items: _bottomBarIcons,
          index: _selectedIndex,
          height: 50.0,
          color: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text('Get Properties'),
            onPressed: () async {
              try {
                await PropertyService().fetchAndAddProperties({
                  'city': 'Lancaster',
                  'state': 'PA',
                  'offset': '400',
                  'limit': '500'
                });
              } catch (e) {
                print('Error in button press: $e');
              }
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                try {
                  await ListingService().fetchAndAddListings({
                    'city': 'Lancaster',
                    'state': 'PA',
                    'status': 'Active',
                    'limit': '500'
                  });
                } catch (e) {
                  print('Error in button press: $e');
                }
              },
              child: const Text('Get Listings')),
          // SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () async {
          //     await PropertyService().updateListingsWithPhotos();
          //   },
          //   child: const Text('Update Listings with photos'),
          // ),
          const SizedBox(height: 20),
           ElevatedButton(
            onPressed: () async {
              try {
                await PropertyService().updateListingsWithPhotos();
              } catch (e) {
                print('Error in button press: $e');
              }
            },
            child: const Text('Update Listings with photos'),
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Favorites Screen'));
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Messages Screen'));
  }
}


