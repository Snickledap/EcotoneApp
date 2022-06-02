import 'package:ecotone_app/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


void main() {
  runApp(Information());
}

  final List<String> videoID=[    //replace video id with training videos
    'cR6LOX-uo9E',
    '9MRza3x1_-A',
    '2vNVGZGlUok',
    '_DCsrRmQGTQ',
    '47y41Di7zao',
    'OMOVFvcNfvE',
    'SvKmSNxFHyQ',
    'Eh993__rOxA',
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
        return Container(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 10,
            right: 10,
            ),
            height:220,
            width: 400,
            child: YoutubePlayer(
              progressIndicatorColor: Colors.amber,
              progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.yellow
              ),
              showVideoProgressIndicator: true,
              controller: _youtubeController(index),
            )
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

