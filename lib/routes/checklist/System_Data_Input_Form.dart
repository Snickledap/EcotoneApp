import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SystemInputFormPage());
}


class SystemInputFormPage extends StatelessWidget{
  const SystemInputFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home:DataForm()
    );
  }
}


class DataForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //Header
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Zeus Data Input Form'),
      ),
      //Formatting Text Fields
      body:FormList(),
      bottomNavigationBar: NavBar(),
    );
  }
}

class UserName extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('User Name Place Holder');
  }
}



class FormList extends StatefulWidget{

  @override
  FormListState createState() {
    return FormListState();
  }
}

class FormListState extends State<FormList>{
  final Stream<QuerySnapshot> System_Data_Input_Form = FirebaseFirestore
      .instance
      .collection('System_Data_Input_Form')
      .snapshots();
  final _formKey = GlobalKey<FormState>();
  var Name = Text("Place Holder Name"); // replace Text with the account holder's name from back end
  var Food_Type = '';
  var Food_Waste_Weight= 0 ;
  var Water_Weight = 0;
  var Gallon_Fertilizer = 0;
  var Oz_Fertilizer = 0;
  var Temperature = 0;
  final List <String> _FoodTypes = [
      'Vegetables',
      'Meat',
      'Grains',
  ];


  @override
  Widget build (BuildContext context){
    CollectionReference SystemDataInputForm = FirebaseFirestore.instance.collection('System_Data_Input_Form');
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      reverse: true,
      child: Column(
        children:<Widget>[
         Name, // replace after back end is connected for further customization
         SizedBox(
           height:350,
           child: InkWell(
             splashColor: Colors.transparent,
             child: SingleChildScrollView(
               padding: const EdgeInsets.only(
                 top: 5,
                 bottom: 5,
                 left: 5,
                 right: 5,
               ),
              reverse: true,
               child: Form(
                key: _formKey,
                  child: Column(
                  children: <Widget>[
                    FormField(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                  color: Colors.redAccent, fontSize: 16.0),
                              hintText: 'Please select a Food Type/s',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          isEmpty: _FoodTypes == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _FoodTypes.last,// change to depend on the selected item + other items if needed
                              isDense: true,
                              onChanged: null, // add a functionality to onChanged
                              items: _FoodTypes.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: const InputDecoration(
                        label: Text('Food Waste Weight'),
                        border: const OutlineInputBorder(),
                        hintText: 'Your Answer',
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      onChanged: (value){
                        Food_Waste_Weight = int.parse(value);
                      },
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return 'Please Enter the Weight of the Food Waste';
                        }
                        return null;
                      },
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: const InputDecoration(
                        label: Text('Water Weight'),
                        border: OutlineInputBorder(),
                        hintText: 'Your Answer',
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      onChanged: (value){
                        Water_Weight = int.parse(value);
                      },
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return 'Please enter the Weight of the Water';
                        }
                        return null;
                      },
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: const InputDecoration(
                        label: Text('Gallon Size Fertilizer You Drained'),
                        border: OutlineInputBorder(),
                        hintText: 'Your Answer',
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      onChanged: (value){
                        Gallon_Fertilizer = int.parse(value);
                      },
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return 'Please enter the number of Gallon Size Fertilizer You Drained';
                        }
                        return null;
                      },
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: const InputDecoration(
                        label: Text('16-Oz Size Fertilizer You Drained'),
                        border: OutlineInputBorder(),
                        hintText: 'Your Answer',
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      onChanged: (value){
                        Oz_Fertilizer = int.parse(value);
                      },
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return 'Please enter the number of 16-Oz Size Fertilizer You Drained';
                        }
                        return null;
                      },
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: const InputDecoration(
                        label: Text('Temperature (Fahrenheit)'),
                        border: const OutlineInputBorder(),
                        hintText: 'Your Answer',
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      onChanged: (value){
                        Temperature = int.parse(value);
                      },
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return 'Please enter the Guts' 'Temperature';
                        }
                        return null;
                      },
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    ),
                  ],
                ),
                ),
             ),
           ),
         ),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          SizedBox(
              height: 55,
              width: 300,
              //Button
              child: ElevatedButton(
                //Button Action
                onPressed: (){if (_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Adding Your Data to the Cloud FireStore'),
                      )
                  );
                  SystemDataInputForm.add({'Name': Name.data,
                    'Food_Type': _FoodTypes.last, //take the value of the text field
                    'Food_Waste_Weight': Food_Waste_Weight,
                    'Water_Weight': Water_Weight,
                    'Gallon_Fertilizer': Gallon_Fertilizer,
                    'Oz_Fertilizer': Oz_Fertilizer,
                    'Temperature': Temperature,
                    'Date':DateTime.now()})
                      .then((value) => print('System Data Saved'))
                      .catchError((error) => print('Something went wrong and was not able to add user;$error'));
                }
                },
                //Button Text
                child: const Text('Submit',
                  style: TextStyle(
                      fontSize: 26
                  ),
                ),
              )
          ),
      ],
      ),
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
