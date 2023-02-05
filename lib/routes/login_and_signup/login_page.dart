import 'package:ecotone_app/main.dart';
import 'package:ecotone_app/routes/login_and_signup//login_setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';



Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController loginEmailController =  TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController teamMemberPasswordController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    teamMemberPasswordController.dispose();
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
    return  Scaffold(
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
                          icon: const Icon(Icons.arrow_back),
                          onPressed: (){
                            Navigator.pop(
                              context);
                          }
                      ),
                    ),
                    body: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
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
                                    padding: const EdgeInsets.symmetric(vertical:40, horizontal: 20),
                                    child: TextFormField(
                                      controller: loginEmailController,
                                      decoration: const InputDecoration(
                                        hintText:"Enter Your Email",
                                      ) ,
                                      validator: (val){
                                        if(val!.isEmpty) {
                                          return "Please Enter Your Email";
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: loginPasswordController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Password",
                                      ),
                                      validator: (val){
                                        if(val!.isEmpty) {
                                          return "Please enter the Password ";
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                            Text(
                              'Or',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                            InkWell(                                                // google Sign in Button
                                splashColor: Colors.white,
                                onTap: (){
                                  FirebaseAuthMethods(FirebaseAuth.instance)
                                      .signInWithGoogle(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                          ]
                      ),
                    )
                );
              }
            },
          ),
        );
  }
}