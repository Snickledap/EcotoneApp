import 'package:flutter/material.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
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

    );
  }
}