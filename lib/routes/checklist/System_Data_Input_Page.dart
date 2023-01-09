import 'package:ecotone_app/NavBar_Consumer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';



class System_Data_Input_Page extends StatelessWidget {
  const System_Data_Input_Page({super.key});


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //Header
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Zeus Data Input Form'),
        ),
        //Formatting Text Fields
        body:FormList(),
        bottomNavigationBar: NavBar_Consumer(),
      ),
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
  final Stream<QuerySnapshot> System_Data_input_Form = FirebaseFirestore
      .instance
      .collection('System_Data_input_Form')
      .snapshots();
  final _systemDataKey = GlobalKey<FormState>();
  var Name, Food_Type,Food_Waste_Weight,Water_Weight,Gallon_Fertilizer,Oz_Fertilizer,Temperature;
  List <String>_FoodTypes = [
    'Vegetables',
    'Meat',
    'Grains',
  ];
  String _currentlySelectedValue='';

  FormListState(){

    Name = Text("Any Name"); // replace Text with the account holder's name from back end
    Food_Type = '';
    Food_Waste_Weight= 0 ;
    Water_Weight = 0;
    Gallon_Fertilizer = 0;
    Oz_Fertilizer = 0;
    Temperature = 0;
    _currentlySelectedValue = _FoodTypes.last;
  }



  @override
  Widget build (BuildContext context){

    CollectionReference SystemDataInputForm = FirebaseFirestore.instance.collection('System_Data_input_Form');
    return Column(
      children:<Widget>[
       SizedBox(
         height: 5.h,
           child: Center(child: Name),
       ), // replace after back end is connected for further customization
        SizedBox(
          height: 50.h,
          child: Container(
           padding: EdgeInsets.symmetric(horizontal: 2.w),
           child: Form(
            key: _systemDataKey,
              child: ListView.builder(
                itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 8.h,
                          width: 80.w,
                          child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                      color: Colors.redAccent, fontSize: 16.0),
                                  hintText: 'Please select a Food Type/s',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                              isEmpty: _currentlySelectedValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentlySelectedValue,// change to depend on the selected item + other items if needed
                                  isDense: true,
                                  onChanged:(newValue) {
                                    setState(() {
                                      _currentlySelectedValue = newValue as String;
                                      state.didChange(newValue);
                                    });
                                  }, // add a functionality to onChanged
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
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 1.w)),
                        Center(
                          child: SizedBox(
                            height: 8.h,
                            width: 14.w,
                            child: ElevatedButton(onPressed: (){}, child: Icon(Icons.add))
                          ),
                        )
                    ],),
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
                          return "Please enter the Gut's Temperature";
                        }
                        return null;
                      },
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    ),
                  ],
                );
              },
            ),
            ),
       ),
        ),
        Padding(padding: EdgeInsets.only(top: 3.h, bottom: 3.h)),
        SizedBox(
            height: 7.h,
            width: 75.w,
            //Button
            child: ElevatedButton(
              //Button Action
              onPressed: (){if (_systemDataKey.currentState!.validate()){
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adding Your Data to the Cloud FireStore'),
                    )
                );
                SystemDataInputForm.add({
                  'Name': Name.data,
                  'Food_Type': _currentlySelectedValue, //take the value of the text field
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
    );
      }
  }

  class DropDownFT extends StatefulWidget {
    const DropDownFT({Key? key}) : super(key: key);

    @override
    State<DropDownFT> createState() => _DropDownFTState();
  }
List <String>_FoodTypes = [
  'Vegetables',
  'Meat',
  'Grains',
];
String _currentlySelectedValue='';

  class _DropDownFTState extends State<DropDownFT> {
    @override
    Widget build(BuildContext context) {
      return SizedBox(
        height: 8.h,
        width: 80.w,
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select a Food Type/s',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              isEmpty: _currentlySelectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentlySelectedValue,// change to depend on the selected item + other items if needed
                  isDense: true,
                  onChanged:(newValue) {
                    setState(() {
                      _currentlySelectedValue = newValue as String;
                      state.didChange(newValue);
                    });
                  }, // add a functionality to onChanged
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
