import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'ownfilecardvideowidget.dart';

class OwnfileCard extends StatelessWidget {
  final message;
  final String messageType;
  OwnfileCard(this.message, this.messageType);

  @override
  Widget build(BuildContext context) {
    return messageType == "image"
        ? Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.8,
                height: MediaQuery.of(context).size.height / 2.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff4a39e3)),
                child: Card(
                  margin: EdgeInsets.all(3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Image.memory(message),
                ),
              ),
            ),
          )
        : OwnVideoCard(message,messageType);
  }
}
