import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar_Consumer.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../login/Login_Setup.dart';


String points = "100";
class Consumer_Profile extends StatefulWidget {
  const Consumer_Profile({Key? key}) : super(key: key);

  @override
  State<Consumer_Profile> createState() => Consumer_ProfileState();
}

class Consumer_ProfileState extends State<Consumer_Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SlidingUpPanel(
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            minHeight: MediaQuery.of(context).size.height*0.56,
            maxHeight: MediaQuery.of(context).size.height*0.68,
            body: CProfileBody(),
            panelBuilder: (controller) => CProfilePanel(
              controller:controller,
            ),
          ),
        //Bottom Navigation Bar
        bottomNavigationBar: NavBar_Consumer(),
      );

  }
}

class CProfileBody extends StatefulWidget {
  const CProfileBody({Key? key}) : super(key: key);

  @override
  State<CProfileBody> createState() => _CProfileBodyState();
}

class _CProfileBodyState extends State<CProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.green),
        child: Stack(
          children: <Widget>[
            Image.asset("lib/assets/images/pexels-akil-mazumder-1072824.jpg"),
            Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height:75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient:LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFddedc8),
                          Colors.green.withAlpha(150),
                          Colors.lightGreen.withAlpha(150),
                          Colors.greenAccent.withAlpha(150),
                        ]
                    )
                ),
                child: FittedBox(
                  child: Icon(Icons.person_outline,
                    color: Colors.black,),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )],
        ),
      ),
    );
  }
}


class CProfilePanel extends StatefulWidget {
  const CProfilePanel({Key? key, required this.controller}) : super(key: key);
  final ScrollController controller;
  @override
  State<CProfilePanel> createState() => _CProfilePanelState();
}

class _CProfilePanelState extends State<CProfilePanel> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(10)),
            Text(
              "Hello, User",
              style: TextStyle(fontSize: 24),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            const Text(
              "Your Soil Sauce Points",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              "$points",
              style: TextStyle(fontSize: 30),
            ),

            const Padding(padding: EdgeInsets.all(55)),
            Container(
              height:75,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red
              ),
              child: IconButton(
                style:ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF860101),
                  elevation: 4,
                ),
                onPressed: (){
                  context.read<FirebaseAuthMethods>().signOut(context);
                },
                icon: Icon(Icons.power_settings_new),
                color: Colors.white
              ),
            )
          ],
        )
    );
  }
}

