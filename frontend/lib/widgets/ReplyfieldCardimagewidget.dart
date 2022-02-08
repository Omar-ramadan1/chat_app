import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ReplyfileCard extends StatelessWidget {
final message;
  ReplyfileCard(this.message);
  @override
  Widget build(BuildContext context) {
    return
     Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: Container(
          width: MediaQuery.of(context).size.width/1.8,
          height: MediaQuery.of(context).size.height/2.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:  Color(0xff4a39e3)
          ),
          child: Card(
            margin: EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
        child: Image.memory(message),

          ),

        ),

      ),
    );
  }
}