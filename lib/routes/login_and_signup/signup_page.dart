import 'package:ecotone_app/routes/login_and_signup/login_setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SignUpPage());
}


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});


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
      child:  const Scaffold(
          body: SignUp(),
        ),
    );
  }
}


class SignUp extends StatefulWidget {
  const SignUp({super.key});


  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  final _formKeySignUp = GlobalKey<FormState>();
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
        .signupWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Form(
              key:_formKeySignUp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset("lib/assets/images/Ecotone_Logo_Transparent.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText:"Enter Your Email",
                      ) ,
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      controller:passwordController,
                      validator: (val){
                        if(val!.isEmpty) {
                          return "Please enter the Password";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Enter Your Password",
                      ),
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      controller:confirmPasswordController,
                      validator: (val){
                        if(val!.isEmpty) {
                          return "Please enter the Password Again";
                        }
                        if(val !=passwordController.text) {
                          return "The Passwords Does Not Match";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Confirm Your Password",
                      ),
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
                    height: 100,
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKeySignUp.currentState!.validate()){
                          emailSignUp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF60c301),
                      ),
                      child: Text("Sign Up Through Email",
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}