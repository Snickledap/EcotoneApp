import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';


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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.h,
                    left: 3.w
                  ),
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Hi Employee 1',
                              style: TextStyle(
                                fontSize: 12.sp,
                                  color: Color(0xFF166390),
                              )
                          ),
                          Text('Reminder',
                              style: TextStyle(
                                fontSize: 20.sp,
                                  color: Color(0xFF166390),
                              )
                          ),

                          Text('You have some tasks to complete',
                              style: TextStyle(
                                fontSize: 12.sp,
                                  color: Color(0xFF166390),
                              )
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top:13.h,
                    left: 1.w,
                      right: 2.w,
                    ),
                    child: Column(
                      children: <Widget>[
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
                                      return CustomCard(
                                        borderRadius: 15,
                                        borderColor: Colors.blue,
                                        width: 200,
                                        color: Color(0xffe6eef3),
                                        child: ListTile(
                                          title: Text(
                                                DateFormat.yMMMd().add_jm().format(data
                                                    .docs[index]['Time_Of_Event']
                                                    .toDate())
                                          ),
                                          subtitle: Text('${data
                                              .docs[index]['Name_Of_Event']}'
                                          ),
                                          trailing: IconButton(
                                            alignment: Alignment.centerRight,
                                            icon: Icon(
                                              Icons.alarm_add_outlined,
                                              size: 17.0,
                                              color: Colors.brown[900],
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      );
                                    }
                                );
                              },
                          ),
                        ),
                        //Card Formatting
                      ],
                    )
                ),
                Padding(padding: EdgeInsets.only(top:13.h)),
                SizedBox(
                  height: 7.h,
                  width: 45.w,
                  child: ElevatedButton(
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
                ),
                Padding(padding: EdgeInsets.all(3.h)),
                SizedBox(
                  height: 7.h,
                  width: 45.w,
                  child: ElevatedButton(
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
                ),
                Align(
                  alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.only(right: 5.w),
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



