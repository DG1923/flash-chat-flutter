import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

late User user;

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _chat = TextEditingController();
  FirebaseFirestore _store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  void getCurrentUser() {
    user = auth.currentUser!;
    print(user.email);
  }

  void getMessages() async {
    await for (var messages in _store.collection("messages").snapshots()) {
      for (var message in messages.docs) {
        print(message.data());
      }
    }
  }

  @override
  initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                //Implement logout functionality
                await auth.signOut();
                Navigator.popAndPushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _store.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs;
                  List<Widget> messageWidgets = [];
                  for (var message in messages) {
                    final messageText = message.get("text");
                    final messageSender = message.get("sender");
                    final messageWidget = MessageBubble(
                        text: messageText,
                        sender: messageSender,
                        isMe: user.email == messageSender);
                    messageWidgets.add(messageWidget);
                  }
                  return Expanded(
                    child: ListView(
                      children: messageWidgets,
                    ),
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _chat,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("${_chat.text} va email : ${user.email}");
                      _store.collection("messages").add({
                        "text": _chat.text,
                        "sender": user.email,
                      });
                      _chat.clear();
                      //Implement send functionality.
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  String text;
  bool isMe;
  String sender;
  MessageBubble(
      {super.key,
      required this.text,
      required this.sender,
      required this.isMe});
  Widget chatWidget() {
    BorderRadius borderRadius = BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
        topRight: Radius.circular(1));
    Color colorBackground = Colors.lightBlueAccent;
    Color colorText = Colors.white;
    CrossAxisAlignment  crossAxisAlignment = CrossAxisAlignment.end;
    if (!isMe) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(1),
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      );
      colorBackground = Colors.white;
      colorText = Colors.black45;
      crossAxisAlignment = CrossAxisAlignment.start;
    }

    return Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
      Text(sender,
          style: TextStyle(
            fontSize: 10,
          )),
      Material(
        elevation: 5,
        borderRadius: borderRadius,
        color: colorBackground,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            "${this.text}",
            style: TextStyle(
              fontSize: 18,
              color: colorText,
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: chatWidget(),);
  }
}
