import 'package:ecotone_app/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:expandable/expandable.dart';


void main() {
  runApp(Information());
}


  final List<String> videoID=[    //replace video id with training videos
    'CDV5YjmH7wE',
    'iADMXKMQIg4',
  ];

final List<String> videoDesc=[    //List of video descriptions
  'Ecotone Overview',
  'Seahorse Training',
];

ExpandableController _expandableController(int index){
  return ExpandableController(
    initialExpanded: true
  );
}

YoutubePlayerController _youtubeController(int index) {
  return YoutubePlayerController(
    initialVideoId: videoID[index],
    flags: const YoutubePlayerFlags(
      hideThumbnail: true,
      autoPlay: false,
      mute: false,
    ),
  );
}

class Information extends StatelessWidget{


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home:InformationPage()
    );
  }
}

class InformationPage extends StatefulWidget {
  @override
  State<InformationPage> createState() => InformationPageState();

}
  class InformationPageState extends State<InformationPage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Information'),
          centerTitle: true,
        ),
        body:SingleChildScrollView(
        reverse: true,
            child:Padding(
            padding: EdgeInsets.only(
            bottom:MediaQuery.of(context).viewInsets.bottom),
              child: Container(
              margin: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    VideoList()
          ],
        ),
      )
            )
        ),
        bottomNavigationBar: NavBar(),
      );
    }


  }

class VideoList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: videoID.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder:(context,index){
        //should make a list of video titles
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black
              )
            ),
            child: ExpandablePanel(
              controller: _expandableController(index),
              header: Align(
                alignment: Alignment.center,
                  child: Text('\n'+videoDesc[index]+'\n')),
              expanded: YoutubePlayer(
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.yellow
                ),
                showVideoProgressIndicator: true,
                controller: _youtubeController(index),
              ), collapsed: const Center(
              child: Text( "Expand To Watch Video")
            ),
               //tapHeaderToExpand: true,
            ),
          ),
        );
      },
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

