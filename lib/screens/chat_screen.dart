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

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _chat = TextEditingController();
  FirebaseFirestore _store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
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
                getMessages();
                // await auth.signOut();
                // Navigator.popAndPushNamed(context, WelcomeScreen.id);
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
                    final messageWidget =
                        MessageBubble(text: messageText, sender: messageSender);
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
                      onChanged: (value) {
                        //Do something with the user input.
                      },
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
  String sender;
  MessageBubble({super.key, required this.text, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(sender),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(32),
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                "${this.text}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        ]
      ),
    );
  }
}
