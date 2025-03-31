// import 'package:flutter/material.dart';

// class NavBar extends StatefulWidget {
//   @override
//   State<NavBar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Search',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.notifications),
//           label: 'Notifications',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//       currentIndex: _selectedIndex,
//       selectedItemColor: Colors.amber[800],
//       onTap: _onItemTapped,
//     );
//   }
// }

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Programs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'Nutrition',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xFF3AA508),
      unselectedItemColor: Colors.black,
      onTap:  (index) {
        // Navigate to the corresponding route
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/programs');
            break;
          case 2:
            Navigator.pushNamed(context, '/nutrition');
            break;
          case 3:
            Navigator.pushNamed(context, '/settings');
            break;
        }
        onItemTapped(index); // Update the selected index
      }
    );
  }
}