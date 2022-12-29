import 'package:flutter/material.dart';


List<String> routeNames = ['/QR', "/SystemInput", "/Consumer_Profile"];


class NavBar_Consumer extends StatefulWidget {
  const NavBar_Consumer({Key? key}) : super(key: key);


  @override
  State<NavBar_Consumer> createState() => NavBar_ConsumerState();
}

class NavBar_ConsumerState extends State<NavBar_Consumer> {
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
          icon: Icon(Icons.map, color: Colors.white),
          activeIcon: Icon(Icons.map, color: Colors.lightBlue),
          label: 'QR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
          activeIcon: Icon(Icons.shopping_cart_outlined, color: Colors.lightBlue),
          label: 'System Input',
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

