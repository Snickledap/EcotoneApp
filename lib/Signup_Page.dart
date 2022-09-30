import 'package:ecotone_app/routes/login/Google_Login_Setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main.dart';



Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SignUpPage());
}
class SignUpPage extends StatelessWidget {

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
          body: SignUp(),
        ),
      ),
    );
  }
}


class SignUp extends StatefulWidget {

  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void emailSignUp() async{
    FirebaseAuthMethods(FirebaseAuth.instance)
        .SignUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:30, horizontal: 0),
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                  }
              ),
            ),
          ),
          Form(
            key:_formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Image.asset("lib/assets/images/Ecotone_Logo_Transparent.png"),
                  height: 200,
                  width: 200,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, right: 10, left: 10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText:"Enter Your Email",
                    ) ,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    controller:passwordController,
                    validator: (val){
                      if(val!.isEmpty)
                        return "Please enter the Password";
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                    ),
                  ),
                ),Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    controller:confirmPasswordController,
                    validator: (val){
                      if(val!.isEmpty)
                        return "Please enter the Password Again";
                      if(val !=passwordController.text)
                        return "The Passwords Does Not Match";
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Confirm Your Password",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, right: 10, left: 10),
                  height: 100,
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()){
                        emailSignUp();
                      }
                    },
                    child: Text("Sign Up Through Email",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF60c301),
                    ),
                  ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}