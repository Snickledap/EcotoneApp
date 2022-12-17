import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecotone_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ecotone_app/routes/login/Login_Setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Profile());
}

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notSwitched = false;

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://involvemint.io/');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

final Stream<QuerySnapshot> Reminder = FirebaseFirestore
    .instance
    .collection("Reminder")
    .orderBy('Time_Of_Event')
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
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 1.h,
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
                                fontSize: 13.sp,
                                  color: Color(0xFF166390),
                              )
                          ),
                          Text('Reminder',
                              style: TextStyle(
                                fontSize: 25.sp,
                                  color: Color(0xFF166390),
                              )
                          ),

                          Text('You have some tasks to complete',
                              style: TextStyle(
                                fontSize: 13.sp,
                                  color: Color(0xFF166390),
                              )
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 1.h)),
                Container(
                  height: 63.h,
                    width: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top:1.h,
                            left: 3.w,
                            right: 3.w,
                          ),
                          height: 15.h,
                          width: 100.w,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: Reminder,
                            builder: (
                            BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot,
                          ) {
                            if(snapshot.hasError){
                              return Text("Soemthing Went Wrong with Snapshot of the Reminder Data");
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
                                  borderRadius: 15.sp,
                                  borderColor: Colors.blue,
                                  width: MediaQuery.of(context).size.width *0.6,
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
                                        size: 25.sp,
                                        color: Colors.brown[900],
                                      ),
                                      onPressed: () {

                                      },
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                    )
                ),
                      Container(
                        height:25.h,
                        width: 100.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                elevation: 4,
                              ),
                              //Button Action
                               onPressed: _launchUrl,
                              //Button Text
                                child: const Text("InvolveMINT")
                          ),
                        ),
                         SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                                elevation: 4,
                              ),
                              //Button Action
                              onPressed: () {
                                context.read<FirebaseAuthMethods>().signOut(context);
                              },
                          //Button Text
                           child: const Text('Sign Out')
                          ),
                        ),
                            ]
                        ),
                      ),
                      Container(
                        child: Switch(
                          value: notSwitched,
                          onChanged: (bool newValue) {
                            setState(() {
                              notSwitched = newValue;
                              Get.to(() => ConsumerRouteGenerator());
                            }
                            );
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      )
                     ],
                    ),
                ),
                       ]
        ),
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



