import 'package:ecotone_app/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:expandable/expandable.dart';
import 'dart:math' as math;


void main() {
  runApp(Information());
}


  final List<String> videoID=[    //replace video id with training videos
    'CDV5YjmH7wE',
    'iADMXKMQIg4',
  ];

  final List<String> videoTitle=[    //List of video title
  'Ecotone Overview',
  'Zeus Training',
  ];

  final List<String> videoDesc=[    //List of Video Descriptions
    'A General Overview of Ecotone and what the comapny does',
    'How to use the Zeus',
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

class VideoList extends StatefulWidget {

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: videoID.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder:(context,index){
        //should make a list of video titles
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0), // shadow direction: bottom right
                  )
                ],
                border: Border.all(
                  color: Colors.black
                )
            ),
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: false,
              ),
              controller: _expandableController(index),
              header: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                          child: Text('\n'+videoTitle[index]+'\n')),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_drop_down,
                            collapseIcon: Icons.arrow_right,
                            iconPadding: EdgeInsets.only(right: 5),
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            hasIcon: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              expanded: Column(
                children: <Widget>[
                  YoutubePlayer(
                    progressIndicatorColor: Colors.amber,
                    progressColors: const ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.yellow
                    ),
                    showVideoProgressIndicator: true,
                    controller: _youtubeController(index),
                  ),
                  Text(videoDesc[index]),
                ],
              ),
              collapsed: const Align(

                alignment: Alignment.center,
                child: Text( '\n'+"Expand To Watch Video"+'\n'),
            ),
               //tapHeaderToExpand: true,
            ),
          ),
        );
      },
    );
  }
}




