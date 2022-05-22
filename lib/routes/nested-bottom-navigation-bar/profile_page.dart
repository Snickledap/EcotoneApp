import 'package:ecotone_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:sizer/sizer.dart';



void main() => runApp(ProfilePage());

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:
          AppBar(
            title: const Text(
                'Profile',
                ),
            titleTextStyle:
              const TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            centerTitle: true,
            backgroundColor: const Color(0xFF309BE9), //Ecotone Colors
          ),
        body:
            Column(
              children:<Widget>[
                  Container(
                    height: 10.0.h,
                        width: 80.0.w,
                        child: Column(
                          children: <Widget>[
                            ListView(
                              scrollDirection: Axis.horizontal,
                              children:  <Widget>[
                                CustomCard(
                                  borderRadius:10,
                                  color: Color(0x10FFFFF),
                                  child: ListTile(
                                    title: Text('time of the event'),
                                    subtitle: Text('name of the event'),
                                    trailing:
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.alarm_add_outlined,
                                            size: 20.0,
                                            color: Colors.brown[900],
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete_outline,
                                            size: 20.0,
                                            color: Colors.brown[900],
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                     ),

             Padding(padding: EdgeInsets.all(10)),
             Align(alignment: Alignment.center),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                elevation: 4,
              ),
              onPressed: (){},
                child: const Text('Sign Out')
              ),
              const Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                elevation: 4,
              ),
              onPressed: (){},
                child: const Text('Involvement')
            ),

   ],
            ),
      ),
    );


  }
  }

