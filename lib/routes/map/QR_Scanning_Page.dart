import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar.dart';



void main() {
  runApp(const QRScanningPage());
}

class QRScanningPage extends StatelessWidget {
  const QRScanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Container Name',
      home: _QRScanningPage(),
    );
  }
}

class _QRScanningPage extends StatefulWidget {
  const _QRScanningPage({Key? key}) : super(key: key);

  @override
  _QRScanningPageState createState() => _QRScanningPageState();
}

class _QRScanningPageState extends State<_QRScanningPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},                   // need to add a function
        ),
        centerTitle: true,
        title: const Text('Name of the Container + #'),
      ),
      body:Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                alignment: Alignment.topCenter,
                height: 200,
                width: 300,
                child: Column(
                  children:const <Widget>[            //remove const modifier when back-end is imported
                  Text(
                  'Location:',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(padding: EdgeInsets.all(5)),
                  Text(
                  "Import data from back-end for actual location, long place holder",
                  style: TextStyle(fontSize: 18,),
                  textAlign: TextAlign.center,
                ),
                  ],
              ),
              ),
              Center(
                child: Column(
                children: <Widget>[
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
                  const Padding(padding: EdgeInsets.all(35)),
                  SizedBox(
                      height:200,
                      width: 350,
                      child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          primary: Color(0xFF3B7621),
                          onPrimary: Colors.white,
                          elevation: 4,
                        ),
                        onPressed: (){},
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

      bottomNavigationBar: NavBar(),
    );

  }
}