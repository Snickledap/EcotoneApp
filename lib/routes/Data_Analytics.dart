import 'package:ecotone_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';


String last_date= "5/28/2022";


void main() {
  runApp(AnalyticsPage());
}

class AnalyticsPage extends StatelessWidget {

@override
Widget build(BuildContext context) {
  return Sizer(builder: (context, orientation, deviceType) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: _DropDownMenu(),
            leadingWidth: 17.w,
            backgroundColor: const Color(0xFF309BE9), //Ecotone Colors
            actions: [
              TextButton(
                style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith((states) => Colors.blue)
              ),
                onPressed: (){},
                child: Text('All',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
                ),
              )
            ],
          ),
          body: SizedBox(
            child: Column(
              children:<Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(onPressed: (){}, child: Text('Today')),
                    TextButton(onPressed: (){}, child: Text('1 Week')),
                    TextButton(onPressed: (){}, child: Text('1 Month')),
                    TextButton(onPressed: (){}, child: Text('3 Months')),
                  ]
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:<Widget>[
                      _TemperatureCard(),
                      _pHCard()
                    ],
                ),
                Padding(padding: EdgeInsets.all(3)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                    _ConductivityCard(),
                    _DateCard(),
                  ],
                ),
                Padding(padding: EdgeInsets.all(3)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                    _StockCard(),
                    _VolumeCard()
                  ],
                ),
                Padding(padding: EdgeInsets.all(3)),
                Ink.image(
                    image: AssetImage('lib/assets/images/PlaceHolderPic2.png'),
                  fit: BoxFit.fill,
                  width: 70.w,
                  height: 16.h,
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
  );
  }
}


class _DropDownMenu extends StatefulWidget {
  const _DropDownMenu({Key? key}) : super(key: key);

  @override
  State<_DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<_DropDownMenu> {
  String dropdownValue = 'Zeus 1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Zeus 1', 'Zeus 2', 'Zeus 3', 'Zeus 4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
        height: 16.h,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 45.w,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
        onTap: (){
        },
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
        height: 16.h,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 50.w,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
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
        height: 16.h,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 60.w,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
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
        height: 16.h,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 35.w,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
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
        height: 16.h,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 40.w,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
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
        height: 16.h,           //needs to be MediaQuery.of(context).size.height * 'a number less than 1'
        width: 55.w,           //needs to be MediaQuery.of(context).size.width * 'a number less than 1'
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
