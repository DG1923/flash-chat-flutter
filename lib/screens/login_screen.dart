import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpiner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpiner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _emailController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kMessageTextFieldDecoration.copyWith(
                  hintText: "Enter your email",
                )
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _passwordController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                obscureText: true,
                decoration: kMessageTextFieldDecoration.copyWith(
                  hintText: "Enter your password",
                  ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        showSpiner = true;
                      });
                      try{
                        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                        if(user.user != null){
                          print(user.user.toString()+" okeeee");
                          Navigator.pushNamed(context, ChatScreen.id);
                        }else{
                          print("lxoi");
                        }
                      } on FirebaseAuthException catch(e){
                        print("Firebase Exception : ${e.code}");
                        setState(() {
                          showSpiner = false;
                        });
                        showCupertinoDialog(context: context, builder: (BuildContext context){
                          return CupertinoAlertDialog(
                            title: Text("Notification"),
                            content: Text("Your email or password is wrong. Try again !"),
                            actions: [
                              CupertinoDialogAction(
                                  child: const Text("Okey"),
                                isDefaultAction:true,
                                onPressed: (){
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                },
                              ),
                            ],
                            insetAnimationDuration: Duration(milliseconds: 500),
                          );
                        });
                      }
                      catch (e){
                        print("${e} ");
                      }
                      setState(() {
                        showSpiner = false;
                      });
                      //Implement login functionality.
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Log In',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
