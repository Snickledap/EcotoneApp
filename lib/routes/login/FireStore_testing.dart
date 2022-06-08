import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FireStorePage());
}


class FireStorePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: TextPage(),
    );
  }
}

class TextPage extends StatelessWidget{
  final Stream<QuerySnapshot> User = FirebaseFirestore
      .instance
      .collection('User')
      .snapshots();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Read and Write Test'),
        centerTitle: true,
      ),
      body: Container(
        child:Column(
          children: <Widget>[
            Text('Text from firestore'),
            Padding(padding: EdgeInsets.all(10)),
            Container(
              height: 200,
              width: 300,
              child: StreamBuilder<QuerySnapshot>(
                stream: User,
                builder:(BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot
                    ) {
                  if (snapshot.hasError){
                    return const Text('Something with the Text is wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return const Text('Loading Text...');
                  }

                  final data = snapshot.requireData;

                  return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return Text(
                            'Hello ${data.docs[index]['First_Name']} '
                                '${data.docs[index]['Last_Name']} '
                                'this is my ${data.docs[index]['Email']} '
                                'and I am ${data.docs[index]['Age']}'
                                ' My Access Tier is ${data.docs[index]['Access_Tier']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12
                        ),);
                      }
                  );
                },
              ),
            ),
            CustomForm(),
          ],
        )
      ),
    );
  }
}

class CustomForm extends StatefulWidget{
  @override
  CustomFormState createState() {
    return CustomFormState();
}
}

class CustomFormState extends State<CustomForm>{
  final _formKey = GlobalKey<FormState>();
  var First_Name = '';
  var Last_Name = '';
  var Email = '';
  var Age = 0 ;
  var Access_Tier = 0;

  @override
  Widget build(BuildContext context){
    CollectionReference User = FirebaseFirestore.instance.collection('User');
    return Form(
        key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What is Your Name?',
              labelText: 'First Name',
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
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person_outline),
              hintText: 'What is Your Last Name?',
              labelText: 'Last Name',
            ),
            onChanged: (value){
              Last_Name = value;
            },
            validator: (value){
              if (value == null || value.isEmpty){
                return 'Please enter your Last Name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'What is Your Email?',
              labelText: 'Email',
            ),
            onChanged: (value){
              Email = value;
            },
            validator: (value){
              if (value == null || value.isEmpty){
                return 'Please enter your Email';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today_outlined),
              hintText: 'How old are you?',
              labelText: 'Age',
            ),
            onChanged: (value){
              Age = int.parse(value);
            },
            validator: (value){
              if (value == null || value.isEmpty){
                return 'Please enter your Age';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.admin_panel_settings),
              hintText: 'What access tier are you',
              labelText: 'Access Tier',
            ),
            onChanged: (value){
              Access_Tier = int.parse(value);
            },
            validator: (value){
              if (value == null || value.isEmpty){
                return 'Please enter your Access Tier';
              }
              return null;
            },
          ),
          Center(
            child: ElevatedButton(
              onPressed: (){
                if (_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adding Your Data to the Cloud FireStore'),
                    )
                  );
                  User.add({'First_Name': First_Name,
                            'Last_Name': Last_Name,
                            'Email': Email,
                            'Age': Age,
                            'Access_Tier': Access_Tier})
                            .then((value) => print('User Data Saved'))
                            .catchError((error) => print('Something went wrong and was not able to add user;$error'));
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
        )
    );
  }

}