import 'package:ecotone_app/routes/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/routes/map/Map_Page.dart';
import 'package:ecotone_app/routes/checklist/Checklist.dart';
import 'package:page_transition/page_transition.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    String initialRoute = "/profile";

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case '/profile':
            return PageTransition(child: ProfilePage(), type: PageTransitionType.fade);
          break;
          case '/map':
            return PageTransition(child: Maping(), type: PageTransitionType.fade);
          break;
          case '/checklist':
            return PageTransition(child: HomePage(), type: PageTransitionType.fade);
          break;

          default:
            return null;
        }
      },
    );
  }
}
