import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecotone_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ecotone_app/routes/login/Login_Setup.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            body:
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      title: Column(
                        children: <Widget>[
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withAlpha(200)
                            ),
                            child: FittedBox(
                              child: Icon(Icons.person_outline,
                                color: Colors.black,),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text("Team Member",
                            style: TextStyle(
                                color: Colors.black
                            ),)
                        ],
                      ),
                      toolbarHeight: 20.h,
                      flexibleSpace: FittedBox(
                        child: Image.asset("lib/assets/images/270nhy.jpg"),
                        fit: BoxFit.fill,
                      ),
                      elevation: 5,
                      actions: <Widget>[
                        Align(alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              context.read<FirebaseAuthMethods>().signOut(context);
                            },
                            icon: Icon(Icons.logout),
                          ),
                        ),
                      ],
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent, //Ecotone Colors
                    ),
                   SliverList(
                       delegate: SliverChildListDelegate(
                           [
                     Container(
                       decoration: BoxDecoration(
                           gradient:LinearGradient(
                               begin: Alignment.topCenter,
                               end: Alignment.bottomCenter,
                               colors: [
                                 Color(0xFFddedc8),
                                 Colors.green.withAlpha(150),
                                 Colors.lightGreen.withAlpha(150),
                                 Colors.greenAccent.withAlpha(150),
                               ]
                           )
                       ),
                       width:double.infinity,
                       height:150.h,
                       child: Column(
                           children: <Widget>[
                             Padding(
                               padding: EdgeInsets.only(top: 0.9.h,
                                   left: 3.w
                               ),
                               child: Container(
                                   child: Align(
                                     alignment: Alignment.centerLeft,
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Text('Reminder',
                                             style: TextStyle(
                                               fontSize: 25.sp,
                                               color: Color(0xFF000000),
                                             )
                                         ),
                                         Text('You have some tasks to complete',
                                             style: TextStyle(
                                               fontSize: 13.sp,
                                               color: Color(0xFF000000),
                                             )
                                         ),
                                       ],
                                     ),
                                   )
                               ),
                             ),
                             Padding(padding: EdgeInsets.symmetric(vertical: 0.9.h)),
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
                                   SizedBox(
                                     height:10.h,
                                     width: 40.w,
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
                                     height:10.h,
                                     width: 40.w,
                                     child: ElevatedButton(
                                       onPressed: (){
                                        Navigator.push(context, MaterialPageRoute (
                                          builder: (BuildContext context) => const ConsumerRouteGenerator(),
                                        ),);
                                       }, child: const Text("Consumer Page"),
                                     ),
                                   )

                                 ],
                               ),
                             ),
                           ]
                       ),
                     ),
                   ]))
                  ],
                ),
            //Top Text Container
        bottomNavigationBar: const NavBar(),
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

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 15;

    var path = Path();
    path.moveTo(0,0);
    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height*0.8);
    path.lineTo(size.width*0.5, size.height);
    path.lineTo(0, size.height*0.8);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomShapePainter oldDelegate) {
    return false;
  }
}

