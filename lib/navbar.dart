import 'package:flutter/material.dart';


List<String> routeNames = [ '/QR', "/Map", "/Consumer_Profile"];


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);


  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  static int selectedIndex = 2;

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
      unselectedItemColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.camera, color: Colors.white),
          activeIcon: Icon(Icons.camera, color: Colors.lightBlue),
          label: 'QR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map, color: Colors.white),
          activeIcon: Icon(Icons.map, color: Colors.lightBlue),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, color: Colors.white),
          activeIcon: Icon(Icons.person_outline, color: Colors.lightBlue),
          label: 'Profile',
        ),
      ],
    onTap: (int index) {
      onItemTapped(index);
      },
    );
  }
}

