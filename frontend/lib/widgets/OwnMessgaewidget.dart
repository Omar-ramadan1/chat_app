import 'dart:typed_data';

import 'package:delivery_app/Logic/IndividualScreenLogic.dart';
import 'package:delivery_app/widgets/ownfilecardimagewidget.dart';
import 'package:flutter/material.dart';

class OwnMessageCard extends StatefulWidget {
   final message;
   final String time , messageType;
       final bool counter;


   OwnMessageCard(this.message,this.time, this.messageType,this.counter);

  @override
  State<OwnMessageCard> createState() => _OwnMessageCardState();
}

class _OwnMessageCardState extends State<OwnMessageCard> {

  
  IndividualScreenLogic? individualScreenLogic;
//Uint8List? imageBytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    individualScreenLogic = IndividualScreenLogic(this);
  }

  @override
  Widget build(BuildContext context) {
    return 
     widget.messageType == "text" ?
    Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width-290,
          maxWidth: MediaQuery.of(context).size.width ,
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/11,
              width: MediaQuery.of(context).size.width/1.2,
              decoration: BoxDecoration(borderRadius:BorderRadius.circular(2) ),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Color(0xff4a39e3),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 20,
                        top: 5,
                        bottom: 20,
                      ),
                      child: widget.messageType == "text" ? Text(
                        widget.message,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ) : 
                      //OwnfileCard()
                      Image.memory(widget.message),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 10,
                      child: Row(
                        children: [
                          Text(
                            widget.time,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
            widget.counter == false?              Icon(
                            Icons.done,
                            size: 20,
                          ):Icon(
                            Icons.done_all  ,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ) 
    :OwnfileCard(widget.message,widget.messageType);
  }
}
