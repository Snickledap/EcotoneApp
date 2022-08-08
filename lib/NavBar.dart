import 'package:ecotone_app/routes/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/routes/map/Map_Page.dart';

List<String> routeNames = ['/map', '/data_analytics', '/checklist', "/info", "/profile"];

enum TabItem {map, checklist, info, profile, analytics}

const Map<TabItem, String> tabName = {
  TabItem.map: 'Map',
  TabItem.checklist: 'Checklist',
  TabItem.info: 'Info',
  TabItem.profile: 'Profile',
  TabItem.analytics: 'Analytics',
};

const Map<TabItem, IconData> tabIcon = {
  TabItem.map: Icons.location_on,
  TabItem.checklist: Icons.checklist,
  TabItem.info: Icons.help_outline,
  TabItem.profile: Icons.person_outline,
  TabItem.analytics: Icons.analytics,
};

class TabNavigatorRoutes {
  static const String map = '/map';
  static const String checklist = '/checklist';
  static const String info = '/info';
  static const String profile = '/profile';
  static const String analytics = '/analytics';
}

class NavBar2 extends StatelessWidget {
  NavBar2({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) =>
                routeBuilders[TabNavigatorRoutes.profile]!(context)),
    );

  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.profile: (context) => ProfilePage(),

    };
  }

  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);

    return Navigator(
      key: navigatorKey,

    );
  }
}





//**************************************************************
  class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);


  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  static int selectedIndex = 4;

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
          icon: Icon(Icons.location_on, color: Colors.white),
          activeIcon: Icon(Icons.location_on, color: Colors.lightBlue),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics, color: Colors.white),
          activeIcon: Icon(Icons.analytics, color: Colors.lightBlue),
          label: 'Analytics',
    ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist, color: Colors.white),
          activeIcon: Icon(Icons.checklist, color: Colors.lightBlue),
          label: 'Checklist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline, color: Colors.white),
          activeIcon: Icon(Icons.help_outline, color: Colors.lightBlue),
          label: 'Info',
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

