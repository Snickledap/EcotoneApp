import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              height: 500,
              width: 400,
              child: StreamBuilder<QuerySnapshot>(
                stream: User,
                builder:(BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot
                    ) {
                  if (snapshot.hasError){
                    return Text('Something with Text is wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Text('Loading Text...');
                  }

                  final data = snapshot.requireData;

                  return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return Text(
                            'Hello ${data.docs[index]['First Name']} '
                                '${data.docs[index]['Last Name']} '
                                'this is my ${data.docs[index]['Email']} '
                                'and I am ${data.docs[index]['Age']}'
                                ' My Access Tier is ${data.docs[index]['Access Tier']}');
                      }
                  );
                },
              ),
            ),

          ],
        )
      ),
    );
  }
}