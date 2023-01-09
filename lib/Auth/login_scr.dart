import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:walk_to_me/Auth/auth_services.dart';
import 'package:walk_to_me/Auth/register_scr.dart';
import 'package:walk_to_me/components/my_button.dart';
import 'package:walk_to_me/components/my_text_field.dart';
import 'package:walk_to_me/components/square_title.dart';
import 'package:walk_to_me/home_scr.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // sign controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // sign user in Method

  void signUserInMethod() async{

    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_UkrzGeRgj9.json'));
        }
    );

    //try sign in
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
      );
       //pop the circle
       Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      //pop the circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {

        showDialog(context: context, builder: (context){
          return AlertDialog(title: Center(child: Text("Incorrect Email",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),backgroundColor: Colors.red[300],);
        });

        // WRONG PASSWORD
      } else if (e.code == 'wrong-password') {

        showDialog(context: context, builder: (context){
          return AlertDialog(title: Center(child: Text("Incorrect Password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),backgroundColor: Colors.red[300],);
        });
      }
    }
    // end of try & catch
    Navigator.push(context, MaterialPageRoute(builder: (c){
      return HomePage();
    }));
  }

  // navigate to register page
  void navigateToRegisterPage() {
    Navigator.push(context, MaterialPageRoute(builder: (c){
      return RegisterPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  SizedBox(height: 50.0,),
                  Icon(
                    Icons.lock ,
                    size: 100.0,
                  ),
                  SizedBox(height: 50.0,),
                  Text(
                      'Welcome back , you\'ve been missed!',
                      style: TextStyle(
                         color: Colors.grey[700],
                         fontSize: 16.0,
                      ),
                  ),
                  SizedBox(height: 25.0,),
                  MyTextField(
                    controller: emailController,
                    hintText: "Email Address",
                    obscureText: false,
                  ),
                  SizedBox(height: 10.0,),
                  MyTextField(
                     controller: passwordController,
                     hintText: "Password",
                     obscureText: true,
                  ),
                  SizedBox(height: 25.0,),
                  MyButton(
                    buttonText: 'Sign In',
                    onTap: signUserInMethod,
                  ),
                  SizedBox(height: 50.0,),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          endIndent: 4,
                          indent: 4,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                          'Or continue with ',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          endIndent: 4,
                          indent: 4,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google Button
                      SquareTitle(
                        onTap: () {
                          GoogleAuthServices().signInWithGoogle();
                          print('Google');
                        },
                        imagePath: 'assets/images/google.png',
                      ),
                      SizedBox(width: 25.0,),
                      // Facebook Button
                      SquareTitle(
                        onTap: (){
                          FacebookAuthServices().signInWithFacebook();
                        },
                        imagePath: 'assets/images/facebook-logo-481.png',
                      ),
                    ],
                  ),
                  SizedBox(height: 17.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member ? ',

                      ),
                      TextButton(
                        onPressed: navigateToRegisterPage,
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
