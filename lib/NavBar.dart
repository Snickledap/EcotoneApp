import 'package:flutter/material.dart';


List<String> routeNames = ['/map', '/checklist', "/info", "/profile"];


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);


  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  static int selectedIndex = 3;

  void onItemTapped(int index) {
    Navigator.pushReplacementNamed(context, routeNames[index]);

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on, color: Colors.black),
          label: 'Map',

        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist, color: Colors.black),
          label: 'Checklist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline, color: Colors.black),
          label: 'Info',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, color: Colors.black),
          label: 'Profile',
        ),
      ],
    onTap: (int index) {
      onItemTapped(index);
      },
    );
  }
}

