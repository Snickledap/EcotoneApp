import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar_Consumer.dart';


class QRScanningPage extends StatefulWidget {
  const QRScanningPage({Key? key}) : super(key: key);

  @override
  QRScanningPageState createState() => QRScanningPageState();
}

class QRScanningPageState extends State<QRScanningPage> {

  @override
  Widget build(BuildContext context) {

    //Back Button
    return MaterialApp(
      home: Scaffold(
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
                            primary: Color(0xFF3B7621),
                            onPrimary: Colors.white,
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
        bottomNavigationBar: const NavBar_Consumer(),
      ),
    );

  }
}