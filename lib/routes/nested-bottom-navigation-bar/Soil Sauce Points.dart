import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



String points = "100";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Checklist',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ecotone'),
        ),
        body: Center(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "You have earned $points Soil Sauce Points!",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(35)),
              SizedBox(
               height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: Color(0xFF3B7621),
                      onPrimary: Colors.white,
                      elevation: 4,
                    ),
                    onPressed: (){},
                    child: Text(
                        "Shop Soil Sauce",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center
                    ),
                  ),
              ),
              const Padding(padding: EdgeInsets.all(20)),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                  primary: Color(0xFF015486),
                  onPrimary: Colors.white,
                  elevation: 4,
                ),
                onPressed: (){},
                child: Text(
                  "Back",
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center
                ),
              ),
            )
            ],
        )
    )
    );
  }
}