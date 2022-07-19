import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecotone_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:firebase_core/firebase_core.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  final Stream<QuerySnapshot> Reminder = FirebaseFirestore
      .instance
      .collection("Reminder")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
    return Scaffold(
            //Header
            appBar:
            AppBar(
              title: const Text(
                'Profile',
              ),
              //Header Format
              titleTextStyle:
              const TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
              centerTitle: true,
              backgroundColor: const Color(0xFF309BE9), //Ecotone Colors
            ),
            body:
            //Top Text Container
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15,
                    left: 10
                  ),
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(padding: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Hi Employee 1',
                                style: TextStyle(
                                  fontSize: 17,
                                    color: Color(0xFF166390),
                                )
                            ),
                            Text('Reminder',
                                style: TextStyle(
                                  fontSize: 30,
                                    color: Color(0xFF166390),
                                )
                            ),

                            Text('You have some tasks to complete',
                                style: TextStyle(
                                  fontSize: 15,
                                    color: Color(0xFF166390),
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                ),
                Container(
                    //Top Text Format
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        //Card Formatting
                        Padding(padding: EdgeInsets.all(10)),
                        Text('Today'),
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          height: 100,
                          width: 500,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: Reminder,
                            builder: (
                            BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot,
                            ) {
                              if(snapshot.hasError){
                                return Text("Soemthing Went Wrong with Snapshot of the Remidner Data");
                              }
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Text("Reminder Data is Loading");
                              }
                              final data = snapshot.requireData;
                              return
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.size,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:(context,index){
                                      return Container(
                                          height: 100,
                                          width: 191,
                                          child:ScrollConfiguration(
                                            behavior: MyBehavior(),
                                            child: ListView(
                                              children: <Widget>[
                                                CustomCard(
                                                  borderRadius: 15,
                                                  borderColor: Colors.blue,
                                                  width: 25,
                                                  color: Color(0xffe6eef3),
                                                  child: ListTile(
                                                    title: Text('${data.docs[index]['Time_Of_Event']}'),
                                                    subtitle: Text('${data.docs[index]['Name_Of_Event']}'),
                                                    trailing:
                                                    IconButton(
                                                      alignment: Alignment.centerRight,
                                                      icon: Icon(
                                                        Icons.alarm_add_outlined,
                                                        size: 17.0,
                                                        color: Colors.brown[900],
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                      );
                                    }
                                );
                              },

                          ),
                        ),
                        //Card Formatting
                        Padding(padding: EdgeInsets.all(10)),
                        Text('This Week'),
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          height: 100,
                          width: 500,
                          child:ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder:(context,index){
                                return Container(
                                    height: 100,
                                    width: 191,
                                    child:ScrollConfiguration(
                                      behavior: MyBehavior(),
                                      child: ListView(
                                        children: <Widget>[
                                          CustomCard(
                                            borderRadius: 15,
                                            borderColor: Colors.blue,
                                            width: 25,
                                            color: Color(0xffe6eef3),
                                            child: ListTile(
                                              title: Text('time of the event'),
                                              subtitle: Text('name of the event'),
                                              trailing:
                                              IconButton(
                                                alignment: Alignment.centerRight,
                                                icon: Icon(
                                                  Icons.alarm_add_outlined,
                                                  size: 17.0,
                                                  color: Colors.brown[900],
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                );
                              }
                          ),
                        ),

                        //Button Formatting
                        //Button
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              elevation: 4,
                            ),
                            //Button Action
                            onPressed: () {},
                            //Button Text
                            child: const Text("InvolveMINT")
                        ),

                        //Button Formatting
                        const Padding(padding: EdgeInsets.all(5)),
                        //Button
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              onPrimary: Colors.white,
                              elevation: 4,
                            ),
                            //Button Action
                            onPressed: () {},
                            //Button Text
                            child: const Text('Sign Out')
                        ),

                      ],
                    )
                ),
                Align(
                  alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: FloatingActionButton(
                        tooltip:"Add Reminders",
                          child: Icon(Icons.add,
                          color: Colors.white,),
                          onPressed: (){}),
                    )
                ),
            ],
            ),
            //Bottom Nav Bar
            bottomNavigationBar: NavBar(),
          );
      },
    );

  }
}




class MyBehavior extends ScrollBehavior{
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details){
    return child;
  }
}



