import 'package:ecotone_app/main.dart';
import 'package:ecotone_app/routes/login/Login_Setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LogIn_Page());
}

class LogIn_Page extends StatefulWidget {
  const LogIn_Page({super.key});


  @override
  State<LogIn_Page> createState() => _LogIn_PageState();
}

class _LogIn_PageState extends State<LogIn_Page> {

  final _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController loginEmailController =  TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
  }

  void emailLogin() async {
    FirebaseAuthMethods(FirebaseAuth.instance)
        .loginWithEmail(
        email: loginEmailController.text,
        password: loginPasswordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(
              FirebaseAuth.instance),
        ),
        StreamProvider(create: (context) => context.read<FirebaseAuthMethods>().authState, initialData: null,)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return const RouteGenerator();
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something Went Wrong with the Sign in"));
              } else {
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading:IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){
                            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()
                  ));
                          }
                      ),
                    ),
                    body: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                          children: <Widget>[
                            Text(
                              'Sign In With Email',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                              ),
                            ),
                            Form(
                              key:_formKeyLogin,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical:40, horizontal: 20),
                                    child: TextFormField(
                                      controller: loginEmailController,
                                      decoration: InputDecoration(
                                        hintText:"Enter Your Email",
                                      ) ,
                                      validator: (val){
                                        if(val!.isEmpty)
                                          return "Please Enter Your Email";
                                        return null;
                                      },
                                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: loginPasswordController,
                                      decoration: InputDecoration(
                                        hintText: "Enter Your Password",
                                      ),
                                      validator: (val){
                                        if(val!.isEmpty)
                                          return "Please enter the Password ";
                                        return null;
                                      },
                                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                      height: 100,
                                      width: 400,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          if (_formKeyLogin.currentState!.validate()){
                                            emailLogin();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF309be9),
                                        ),
                                        child: Text("SIGN IN",
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                            Text(
                              'Or',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                            InkWell(                                                // google Sign in Button
                                splashColor: Colors.white,
                                onTap: (){
                                  FirebaseAuthMethods(FirebaseAuth.instance)
                                      .signInWithGoogle(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 60,
                                  width: 350,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            height: 50,
                                            width: 50,
                                            "lib/assets/images/google-logo.png"),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height*0.1,
                                          width: MediaQuery.of(context).size.width*0.6,

                                          child: Center(
                                            child: Text("SIGN IN WITH GOOGLE",
                                              style: GoogleFonts.roboto(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),
                                )
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                            InkWell(                                              // FaceBook in Button
                                splashColor: Colors.white,
                                onTap: (){
                                  FirebaseAuthMethods(FirebaseAuth.instance)
                                      .signInWithFacebook(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF3B5998),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 60,
                                  width: 350,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Icon(
                                          IconData(
                                            0xe255,
                                            fontFamily: 'MaterialICons',

                                          ),
                                          size:48,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height*0.1,
                                          width: MediaQuery.of(context).size.width*0.6,

                                          child: Center(
                                            child: Text("SIGN IN WITH FACEBOOK",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),
                                )
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                            InkWell(                                               // Apple in Button
                                splashColor: Colors.white,
                                onTap: (){
                                  /*FirebaseAuthMethods(FirebaseAuth.instance)
                      .signInWithApple(context);*/
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 60,
                                  width: 350,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Icon(
                                          IconData(
                                            0xf04be,
                                            fontFamily: 'MaterialICons',

                                          ),
                                          size:48,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height*0.1,
                                          width: MediaQuery.of(context).size.width*0.6,

                                          child: Center(
                                            child: Text("SIGN IN WITH APPLE",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),
                                )
                            ),
                          ]
                      ),
                    )
                );
              }
            },
          ),
        ),
      ),
    );
  }
}