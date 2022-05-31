import 'package:ecotone_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
String last_date= "5/28/2022";


void main() => runApp(AnalyticsPage());

class AnalyticsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile',
            ),
            titleTextStyle:
            const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF309BE9), //Ecotone Colors
          ),
          body: Container(
            child: Column(
              children:<Widget>[
                Padding(padding: EdgeInsets.all(5)),
                Text(
                  'Today, Week, Month, 3 Month'
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:<Widget>[
                      _TemperatureCard(),
                      _pHCard()
                    ],
                ),
                Padding(padding: EdgeInsets.all(5)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                    _ConductivityCard(),
                    _DateCard(),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                    _StockCard(),
                    _VolumeCard()
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),
                Ink.image(
                    image: AssetImage('lib/assets/images/PlaceHolderPic1.png'),
                  fit: BoxFit.cover,
                  width: 300,
                  height: 150,
                ),
                  const Text('Last Service Date:'),
                  Text('$last_date'),
                ]
            ),
          ),
          bottomNavigationBar: NavBar(),
    )
    );
  }
}


@override
class _TemperatureCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 125,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 200,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              const Text('Temperature',
              textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF015486),
                  fontSize: 12,
                ),
              ),
             Expanded(
              child: SizedBox(
                height: double.infinity,
               width: double.infinity,
               child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
             )
             ),
            ],
          ),
    );
  }
}


@override
class _pHCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 125,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 150,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('pH',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
                )
            ),
          ],
        ),
    );
  }
}


@override
class _ConductivityCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 125,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 225,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('Electrical Conductivity',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
                )
            ),
          ],
        ),
    );
  }
}


@override
class _DateCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 125,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 125,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('Date',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
                )
            ),
          ],
        ),
    );
  }
}


@override
class _StockCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 125,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 145,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('Fertilizer Stock',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
                )
            ),
          ],
        ),
    );
  }
}



@override
class _VolumeCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 125,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 205,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('Dosing Tank Volume',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
                )
            ),
          ],
        ),
    );
  }
}
