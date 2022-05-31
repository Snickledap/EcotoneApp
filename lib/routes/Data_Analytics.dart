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
          appBar:
          AppBar(
            title: const Text(
              'Profile',
            ),
            titleTextStyle:
            const TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF309BE9), //Ecotone Colors
          ),
          body:
          Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(20)),
                  Container(
                    height: 100,
                    width: 500,
                    child: _CardList(),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  Container(
                    height: 100,
                    width: 500,
                    child: _CardList(),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  Container(
                    height: 100,
                    width: 500,
                    child: _CardList(),
                  ),
                  Padding(padding: EdgeInsets.all(60)),
                  Container(
                    child: Column(
                        children:<Widget>[
                          Text('Last Service Date:'),
                          Text('$last_date'),
                        ]
                    ),
                  ),
                ],
              )
          ),

        )
    );
  }
}


@override
class _customcards extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    return CustomCard(
        borderRadius: 15,
        color: Color(0x10FFFFF),
        child: ListTile(
          title: Text(''),
          subtitle: Text(''),
        )
    );
  }
}

class _CardList extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: 200,
            child: ListView(
              children: <Widget>[
                _customcards()
              ],
            ),
          );
        }
    );
  }
}
