import 'package:ecotone_app/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:expandable/expandable.dart';


void main() {
  runApp(Information());
}

  final List<String> videoID=[    //replace video id with training videos
    'cR6LOX-uo9E',
    '2vNVGZGlUok',
    '_DCsrRmQGTQ',
    '47y41Di7zao',
    'OMOVFvcNfvE',
    'SvKmSNxFHyQ',
    'Eh993__rOxA',
  ];

final List<String> videoDesc=[    //List of video descriptions
  'Training0',
  'Training1',
  'Training2',
  'Training3',
  'Training4',
  'Training5',
  'Training6',
];

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

/*@override
void deactivate() {
  // Pauses video while navigating to next page.
  _youtubeController.pause();
   super.deactivate();
}
*/

class Information extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
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
        return ExpandablePanel(
          header: Text(videoDesc[index]),
          collapsed: Text("", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
          expanded: YoutubePlayer(
            progressIndicatorColor: Colors.amber,
            progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.yellow
            ),
            showVideoProgressIndicator: true,
            controller: _youtubeController(index),
          ),
          // tapHeaderToExpand: true,
          // hasIcon: true,
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

