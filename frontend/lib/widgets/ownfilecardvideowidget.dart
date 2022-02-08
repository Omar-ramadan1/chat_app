import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OwnVideoCard extends StatefulWidget {
  final message;
  final String messageType;
  OwnVideoCard(this.message, this.messageType);

  @override
  State<OwnVideoCard> createState() => _OwnVideoCardState();
}

class _OwnVideoCardState extends State<OwnVideoCard> {
  VideoPlayerController? controller;
  File? video;


  mca() {
      video = File(widget.message.path);
    controller = VideoPlayerController.file(video!)
      ..initialize().then((_) {
        //    Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void initState() {
    super.initState();
    mca();
  }

  @override
  Widget build(BuildContext context) {
    return widget.message == null
        ? Container()
        : Align(
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
                  child: controller!.value.isInitialized ?
                AspectRatio(aspectRatio: controller!.value.aspectRatio,
                child: VideoPlayer(controller!),
                )
                :
                Container()
                ),
              ),
            ),
          );
  }
}
