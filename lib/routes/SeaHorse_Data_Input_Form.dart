
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar.dart';


void main(){
  runApp(MyApp());
}

class Questions {

  String formQuestions;

 Questions({ required this.formQuestions});
}
  List<Questions> questions=[
  Questions(formQuestions: 'Name'),
  Questions(formQuestions: 'Date'),
  Questions(formQuestions: 'Weight of food waste input (lb)'),
  Questions(formQuestions: 'Food waste type (type of vegetables, fruits, carbs, etc)'),
  Questions(formQuestions: 'Weight of water added (lb)'),
  Questions(formQuestions: 'Fertilizer Drained (Gallon Containers)'),
  Questions(formQuestions: 'Fertilizer Drained (16oz Containers)'),
  Questions(formQuestions: 'Temperature of the stomach (Fahrenheit)'),
  ];



class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:SeaHorseDataForm()
    );
  }
}



class SeaHorseDataForm extends StatelessWidget {
  const SeaHorseDataForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sea Horse Data Input Form'),
        ),
        body:SingleChildScrollView(
          reverse: true,
          child:Padding(
          padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Title(color: Colors.black, child: const Text('Form')),
                    Padding(padding: EdgeInsets.all(10)),
                    SizedBox(
                      height: 450,
                      width: 400,
                      child: FormList(),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    _SubmitButton(),
                    Padding(padding: EdgeInsets.all(10)),
                ],
              ),
            ),
            ),
            ),
        bottomNavigationBar: NavBar(),
      );
  }
}



class _TextBoxes extends StatelessWidget {
  int index = 0;
  _TextBoxes(this.index);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
        label: Text(questions[index].formQuestions),
        border: const OutlineInputBorder(),
        hintText: 'Your Answer',
        contentPadding: EdgeInsets.all(10.0),
        ),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      );
  }
}



class _SubmitButton extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return SizedBox(
      height: 55,
        width: 300,
        child: ElevatedButton(
          onPressed: (){},
          child: const Text('Submit',
            style: TextStyle(
              fontSize: 26
            ),
          ),
    ));
  }
}



class FormList extends StatelessWidget {

  @override
  Widget build (BuildContext context){
    return ListView.builder(
      itemCount: questions.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(5),
        itemBuilder:(context,index){
        return SizedBox(
          height: 75,
          width: 400,
          child:ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                _TextBoxes(index)
              ],
            ),
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
