import 'package:flutter/material.dart';

class ButtonScreen extends StatelessWidget {
  ButtonScreen(
      {super.key,
      required this.onPress,
      required this.text,
      required this.color});
  late Function onPress;
  late String text;
  late Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onPress();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
