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
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),

            //Button Action
            onPressed: () {},                   // need to add a function
          ),

          // Header Text
          centerTitle: true,
          title: const Text('Name of the Container + #'),
        ),

        body:Column(
              children: <Widget>[

                //Top Text Format
                Padding(padding: EdgeInsets.only(bottom: 10)),
                Container(
                  alignment: Alignment.topCenter,
                  height: 200,
                  width: 300,

                  //Top Text
                  child: Column(
                    children:const <Widget>[            //remove const modifier when back-end is imported
                    Text(
                    'Location:',
                    style: TextStyle(fontSize: 20),
                  ),

                  //Top Text Subtext
                  Padding(padding: EdgeInsets.all(5)),
                    Text(
                    "Import data from back-end for actual location, long place holder",
                    style: TextStyle(fontSize: 18,),
                    textAlign: TextAlign.center,
                  ),
                    ],
                ),
                ),

                //Center Text
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
                          onPressed: (){},

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