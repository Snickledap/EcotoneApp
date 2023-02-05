import 'package:flutter/material.dart';
import 'package:ecotone_app/navbar.dart';

import 'camera_page.dart';


class QRScanningPage extends StatefulWidget {
  const QRScanningPage({Key? key}) : super(key: key);

  @override
  QRScanningPageState createState() => QRScanningPageState();
}

class QRScanningPageState extends State<QRScanningPage> {

  @override
  Widget build(BuildContext context) {

    //Back Button
    return Scaffold(
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Top Text Format
                const Padding(padding: EdgeInsets.only(bottom: 10)), //Center Text
                Center(
                  child: Column(
                  children: <Widget>[
                    //Center Text Format
                    const SizedBox(
                      width:250,
                      child:Text(
                        "Scan the QR code and input drop off information.",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    //Scan Button Format
                    const Padding(padding: EdgeInsets.all(35)),
                    SizedBox(
                        height:200,
                        width: 350,

                        //Scan Button
                        child: ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF3B7621),
                            elevation: 4,
                          ),

                          //Scan Button Action
                          onPressed: (){
                            Navigator
                              .push(context, MaterialPageRoute(
                              builder: (context) => const ConsumerCamera()
                          ),
                          );
                          },

                          //Scan Button Text
                          child: const Text(
                          "Scan",
                          style: TextStyle(fontSize: 50),
                          textAlign: TextAlign.center
                      ),
                    )
                ),
                ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),

              ],
            ),

        //Bottom Nav Bar
        bottomNavigationBar:  const NavBar(),
      );

  }
}