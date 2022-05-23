import 'package:ecotone_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:sizer/sizer.dart';



void main() => runApp(ProfilePage());

class ProfilePage extends StatelessWidget {

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
          margin: EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              Container(
                height: 500,
                width: 500,
                child: _CardList(),
              ),
            Padding(padding: EdgeInsets.all(10)),
            Align(alignment: Alignment.bottomCenter),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  elevation: 4,
                ),
                onPressed: () {},
                child: const Text('Sign Out')
            ),
            const Padding(padding: EdgeInsets.all(20)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  elevation: 4,
                ),
                onPressed: () {},
                child: const Text('Involvement')
            ),
          ],
        )
      )
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
            title: Text('time of the event'),
            subtitle: Text('name of the event'),
            trailing:
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
            IconButton(
            icon: Icon(
              Icons.alarm_add_outlined,
              size: 20.0,
              color: Colors.brown[900],
            ),
            onPressed: () {},
          ),
        ],
            ),
          ),
        );
    }
  }

class _CardList extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder:(context,index){
      return Container(
        height: 100,
        width: 100,
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



