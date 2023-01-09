import 'package:ecotone_app/routes/map/Camera_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar_Consumer.dart';


class QR_Scanning_Page extends StatefulWidget {
  const QR_Scanning_Page({Key? key}) : super(key: key);

  @override
  QR_Scanning_PageState createState() => QR_Scanning_PageState();
}

class QR_Scanning_PageState extends State<QR_Scanning_Page> {

  @override
  Widget build(BuildContext context) {

    //Back Button
    return Scaffold(
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Top Text Format
                Padding(padding: EdgeInsets.only(bottom: 10)), //Center Text
                Center(
                  child: Column(
                  children: <Widget>[
                    //Center Text Format
                    Container(
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
                            backgroundColor: Color(0xFF3B7621),
                            elevation: 4,
                          ),

                          //Scan Button Action
                          onPressed: (){
                          //   Navigator
                          //     .push(context, MaterialPageRoute(
                          //     builder: (context) => ConsumerCamera()
                          // ),
                          // );
                          },

                          //Scan Button Text
                          child: Text(
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
        bottomNavigationBar:  NavBar_Consumer(),
      );

  }
}