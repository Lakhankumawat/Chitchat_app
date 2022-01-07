import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final msgDocs = snapShot.data!.docs;

          return ListView.builder(
            reverse: true,
            itemCount: msgDocs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              msgDocs[index]['text'],
              msgDocs[index]['userId'] ==
                  FirebaseAuth.instance.currentUser!.uid,
              msgDocs[index]['username'],
              msgDocs[index]['userImage'],
            ),
          );
        });
  }
}
