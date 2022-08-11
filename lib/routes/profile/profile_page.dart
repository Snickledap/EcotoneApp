import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ecotone_app/routes/login/Google_Login_Setup.dart';



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
  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://flutter.dev');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }


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
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.width * 0.05
                  ),
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Hi Employee 1',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).textScaleFactor * 18,
                                  color: Color(0xFF166390),
                              )
                          ),
                          Text('Reminder',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).textScaleFactor * 30,
                                  color: Color(0xFF166390),
                              )
                          ),

                          Text('You have some tasks to complete',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).textScaleFactor * 18,
                                  color: Color(0xFF166390),
                              )
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.12,
                    left: MediaQuery.of(context).size.width*0.02,
                      right: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.16 ,
                          width: MediaQuery.of(context).size.width * 1,
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
                Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.05,)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        elevation: 4,
                      ),
                      //Button Action
                      onPressed: _launchUrl,
                      //Button Text
                      child: const Text("InvolveMINT")
                  ),
                ),
                Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02,)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        elevation: 4,
                      ),
                      //Button Action
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                        provider.logout();
                      },
                      //Button Text
                      child: const Text('Sign Out')
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.07,)),
                Align(
                  alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03,),
                      child: FloatingActionButton(
                        tooltip:"Add Reminders",
                          child: Icon(Icons.add,
                          color: Colors.white,),
                          onPressed: (){}
                          ),
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





