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
  final Stream<QuerySnapshot> System_Data_Input_Form = FirebaseFirestore
      .instance
      .collection('System_Data_Input_Form')
      .snapshots();

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


class FormList extends StatefulWidget{
  @override
  FormListState createState() {
    return FormListState();
  }
}

class FormListState extends State<FormList>{
  final _formKey = GlobalKey<FormState>();
  var First_Name = '';
  var Last_Name = '';
  var Food_Type = '';
  var Food_Waste_Weight= 0 ;
  var Water_Weight = 0;
  var Gallon_Fertilizer = 0;
  var Oz_Fertilizer = 0;
  var Temperature = 0;


  @override
  Widget build (BuildContext context){
    CollectionReference System_Data_Input_Form = FirebaseFirestore.instance.collection('System_Data_Input_Form');
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      reverse: true,
      child: Column(
        children:<Widget>[
         SizedBox(
           height: 475,
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
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: const InputDecoration(
                      label: Text('First Name'),
                      border: const OutlineInputBorder(),
                      hintText: 'Your Answer',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    onChanged: (value){
                      First_Name = value;
                    },
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'Please enter your First Name';
                      }
                      return null;
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: const InputDecoration(
                      label: Text('Last Name'),
                      border: const OutlineInputBorder(),
                      hintText: 'Your Answer',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    onChanged: (value){
                      Last_Name = value;
                    },
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'Please enter your First Name';
                      }
                      return null;
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: const InputDecoration(
                      label: Text('Food Type'),
                      border: const OutlineInputBorder(),
                      hintText: 'Your Answer',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    onChanged: (value){
                      Food_Type = value;
                    },
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'Please enter your First Name';
                      }
                      return null;
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
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
                        return 'Please enter your First Name';
                      }
                      return null;
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
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
                        return 'Please enter your First Name';
                      }
                      return null;
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: const InputDecoration(
                      label: Text('Gallon Fertilizer'),
                      border: OutlineInputBorder(),
                      hintText: 'Your Answer',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    onChanged: (value){
                      Gallon_Fertilizer = int.parse(value);
                    },
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'Please enter your First Name';
                      }
                      return null;
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: const InputDecoration(
                      label: Text('Oz Fertilizer'),
                      border: OutlineInputBorder(),
                      hintText: 'Your Answer',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    onChanged: (value){
                      Oz_Fertilizer = int.parse(value);
                    },
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'Please enter your First Name';
                      }
                      return null;
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: const InputDecoration(
                      label: Text('Temperature'),
                      border: const OutlineInputBorder(),
                      hintText: 'Your Answer',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    onChanged: (value){
                      Temperature = int.parse(value);
                    },
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'Please enter your First Name';
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
          Padding(padding: EdgeInsets.only(bottom: 10)),
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
                  System_Data_Input_Form.add({'First_Name': First_Name,
                    'Last_Name': Last_Name,
                    'Food_Type': Food_Type,
                    'Food_Waste_Weight': Food_Waste_Weight,
                    'Water_Weight': Water_Weight,
                    'Gallon_Fertilizer': Gallon_Fertilizer,
                    'Oz_Fertilizer': Oz_Fertilizer,
                    'Temperature': Temperature})
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
