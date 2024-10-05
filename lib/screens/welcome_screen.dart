import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'button_screen.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{
  late AnimationController control;
  late Animation<double> animation;
  late Animation animationColor;
  @override void initState() {
    // TODO: implement initState
    super.initState();
    control = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this);
    animation = CurvedAnimation(
      parent: control,
      curve: Curves.easeInOutQuint,
    );
    animationColor = ColorTween(begin:Colors.blue,end:Colors.white).animate(animation);
    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        control.reverse(from: 1.0);
      }else if(status == AnimationStatus.dismissed){
        control.forward();
      }
    });
    control.forward();
    control.addStatusListener((status){

    });
    control.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }
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
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60.0*animation.value,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText("Flash Chat",
                    speed: const Duration(milliseconds: 500),
                    textStyle: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    ),
                    curve: Curves.easeInCubic,)
                  ]
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            ButtonScreen(
              color: Colors.lightBlueAccent,
              text: 'Log In',
              onPress: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            ButtonScreen(
              color: Colors.blueAccent,
              text: 'Register',
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
