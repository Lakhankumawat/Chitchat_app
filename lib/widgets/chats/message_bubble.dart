import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool _isMe;
  final String userName;
  final String imageUrl;
  MessageBubble(this.message, this._isMe, this.userName, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomRight:
                      !_isMe ? Radius.circular(12) : Radius.circular(0),
                  bottomLeft: _isMe ? Radius.circular(12) : Radius.circular(0),
                ),
                color: _isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              width: 140,
              child: Column(
                crossAxisAlignment:
                    _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      color: _isMe
                          ? Colors.black87
                          : Theme.of(context).accentTextTheme.headline1!.color,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: _isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: _isMe
                          ? Colors.black87
                          : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                    textAlign: _isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          child: CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage(imageUrl),
          ),
          top: 0,
          right: _isMe ? 130 : null,
          left: _isMe ? null : 130,
        )
      ],
      overflow: Overflow.visible,
    );
  }
}
