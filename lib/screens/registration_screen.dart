import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "logo",
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kMessageTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              )
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _passwordController,
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
              },
              obscureText: true,
              decoration: kMessageTextFieldDecoration.copyWith(
                hintText: "Enter your passsword"
              )
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    print("EMAIL : ${_emailController.text}");
                    print("Password : ${_passwordController.text}");
                    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                      try{
                        UserCredential user = await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                        print(user.user?.email);
                        Navigator.pushNamed(context, ChatScreen.id);
                      }catch (e){
                        print(e.toString());
                      }
                    }
                    //Implement registration functionality.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
