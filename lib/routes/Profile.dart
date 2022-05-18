import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  static const String _title = "Profile Page";

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}



    class MyStatefulWidget extends StatefulWidget {
      const MyStatefulWidget({Key? key}) : super(key: key);

      State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
    }
    class _MyStatefulWidgetState extends State<MyStatefulWidget> {
    int _selectedIndex = 0;
    static const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    static const List<Widget> _widgetOptions = <Widget>[
    Text(
    'Index 0: Map',
    style: optionStyle,
    ),
    Text(
    'Index 1: Checklist',
    style: optionStyle,
    ),
    Text(
    'Index 2: Informational Videos',
    style: optionStyle,
    ),
    Text(
    'Index 3: Profile',
    style: optionStyle,
    ),
    ];

    void _onItemTapped(int index) {
    setState(() {
    _selectedIndex = index;
    }
    );
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(

          title: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
          text: "Ecotone Application",
          style: TextStyle(fontSize: 20),
            children:
            <TextSpan>[
            TextSpan(
            text: '\nBeta',
            style: TextStyle(
            fontSize: 16,
            ),
            ),
            ]
            ),
            ),
            ),

          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on, color: Colors.white),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist, color: Colors.white),
              label: 'Checklist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline, color: Colors.white),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Colors.white),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[400],
          onTap: _onItemTapped,
        )
      );
    }
    }
