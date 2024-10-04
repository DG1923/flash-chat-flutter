import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
const kMessageTextFieldDecoration = InputDecoration(
  hintText: 'Type your message here...',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder:OutlineInputBorder(
    borderSide:BorderSide(color:Color.fromARGB(255, 166, 243, 33),width: 1),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
    borderSide: BorderSide(color: Color.fromARGB(255, 243, 33, 138),width: 2),
  )

);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
