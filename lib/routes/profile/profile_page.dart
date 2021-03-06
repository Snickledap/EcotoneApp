import 'package:ecotone_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';


//void main() => runApp(ProfilePage());

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

          //Header
          appBar:
          AppBar(
            title: const Text(
              'Profile',
            ),

            //Header Format
            titleTextStyle:
            const TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF309BE9), //Ecotone Colors
          ),
          body:

          //Top Text Container
          Container(

              //Top Text Format
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  Title(
                    color: Colors.black,

                    //Top Text
                    child: Column(
                      children: <Widget>[
                        Text('Hi Employee 1'),
                        Padding(padding: EdgeInsets.all(15)),
                        Text('Reminder'),
                        Text('You have some tasks to complete')
                      ],
                    ),
                  ),

                  //Card Formatting
                  Padding(padding: EdgeInsets.all(10)),
                  Text('Today'),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    height: 100,
                    width: 500,
                    child: _CardList(),
                  ),

                  //Card Formatting
                  Padding(padding: EdgeInsets.all(10)),
                  Text('This Week'),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    height: 100,
                    width: 500,
                    child: _CardList(),
                  ),

                  //Button Formatting
                  const Padding(padding: EdgeInsets.all(20)),

                  //Button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        elevation: 4,
                      ),

                      //Button Action
                      onPressed: () {},

                      //Button Text
                      child: const Text('Involvement')
                  ),

                  //Button Formatting
                  const Padding(padding: EdgeInsets.all(10)),

                  //Button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        elevation: 4,
                      ),

                      //Button Action
                      onPressed: () {},

                      //Button Text
                      child: const Text('Sign Out')
                  ),
                ],
              )
          ),

          //Bottom Nav Bar
          bottomNavigationBar: NavBar(),
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
        IconButton(
          alignment: Alignment.centerRight,
          icon: Icon(
            Icons.alarm_add_outlined,
            size: 17.0,
            color: Colors.brown[900],
          ),
          onPressed: () {},
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
        scrollDirection: Axis.horizontal,
        itemBuilder:(context,index){
          return Container(
              height: 100,
              width: 200,
              child:ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: <Widget>[
                    _customcards()
                  ],
                ),
              )


          );
        }
    );
  }

}

class MyBehavior extends ScrollBehavior{
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details){
    return child;
  }
}



