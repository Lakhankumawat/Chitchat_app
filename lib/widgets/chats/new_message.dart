import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMsg = '';
  final _inputController = new TextEditingController();
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _inputController.clear();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMsg,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['name'],
      'userImage': userData['image_url'],
    });
    _enteredMsg = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              onChanged: (value) {
                setState(() {
                  _enteredMsg = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          TextButton(
            onPressed: _enteredMsg.trim().isEmpty ? null : _sendMessage,
            child: Icon(
              Icons.send,
              color: _enteredMsg.trim().isEmpty
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
