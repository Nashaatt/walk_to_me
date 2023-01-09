import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walk_to_me/Auth/auth_services.dart';
import 'package:walk_to_me/components/my_button.dart';
import 'package:walk_to_me/components/my_text_field.dart';
import 'package:walk_to_me/components/square_title.dart';
import 'package:walk_to_me/Auth/login_scr.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // sign controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  // sign user Up Method
  void signUserUpMethod() async {

    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        }
    );

    //try Creating The User
    try {
      // Check Password & ConfirmPassword
      if(passwordController.text == ConfirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      }

      //pop the circle
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      //pop the circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'email-already-in-use') {

        showDialog(context: context, builder: (context){
          return AlertDialog(title: Center(child: Text("Already signed in",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),backgroundColor: Colors.red[300],);
        });

        // WRONG PASSWORD
      } else if (e.code == 'weak-password') {

        showDialog(context: context, builder: (context){
          return AlertDialog(title: Center(child: Text("Weak Password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),backgroundColor: Colors.red[300],);
        });
      }
    }
    Navigator.push(context, MaterialPageRoute(builder: (c){
      return LoginPage();
    }));
  }

  // navigateToLoginPage
  void navigateToLoginPage(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                SizedBox(height: 50.0,),
                Icon(
                  Icons.lock,
                  size: 100.0,
                ),
                SizedBox(height: 50.0,),
                Text(
                  'Let\'s create a new account for you',
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
                SizedBox(height: 10.0,),
                MyTextField(
                  controller: ConfirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                SizedBox(height: 25.0,),
                MyButton(
                  buttonText: 'Sign Up',
                  onTap: signUserUpMethod,
                ),
                SizedBox(height: 25.0,),
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
                SizedBox(height: 15.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Button
                    SquareTitle(
                      onTap: (){
                        GoogleAuthServices().signInWithGoogle();
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
                      'Already a member ? ',

                    ),
                    TextButton(
                      onPressed: navigateToLoginPage,
                      child: Text(
                        'Login Now',
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
    );
  }
}