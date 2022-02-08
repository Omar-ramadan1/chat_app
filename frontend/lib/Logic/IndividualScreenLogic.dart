import 'dart:io';
import 'dart:typed_data';

import 'package:delivery_app/model/SocketModel.dart';
import 'package:delivery_app/model/messagemodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class IndividualScreenLogic {
  final state;
  IndividualScreenLogic(this.state);

  sendImage(context) async {
    final ImagePicker _picker = ImagePicker();
    ImageSource source;
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    Uint8List? imageBytes;
    await pickedFile?.readAsBytes().then((value) => imageBytes = value);
    MessageModel messageModel = MessageModel("source", imageBytes, "image",
        DateTime.now().toString().substring(10, 16));

    Provider.of<SocketModel>(context, listen: false)
        .addMessage(messageModel, state.widget.chatModel["id"]);

    state.socket!.emit("image", {
      "imageData": imageBytes,
      "Sender": state.widget.sourchat["id"],
      "Receiver": state.widget.chatModel["id"]
    });
  }

  sendImagefromgalley(context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    Uint8List? imageBytes;
    await pickedFile?.readAsBytes().then((value) => imageBytes = value);
    MessageModel messageModel = MessageModel("source", imageBytes, "image",
        DateTime.now().toString().substring(10, 16));

    Provider.of<SocketModel>(context, listen: false)
        .addMessage(messageModel, state.widget.chatModel["id"]);

    state.socket!.emit("image", {
      "imageData": imageBytes,
      "Sender": state.widget.sourchat["id"],
      "Receiver": state.widget.chatModel["id"]
    });
  }
    sendVideofromcamera(context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.camera);

    File? file;
    await pickedFile?.readAsBytes();
    MessageModel messageModel = MessageModel("source", pickedFile, "video",
        DateTime.now().toString().substring(10, 16));

   await Provider.of<SocketModel>(context, listen: false)
        .addMessage(messageModel, state.widget.chatModel["id"]);

    state.socket!.emit("video", {
    //  "imageData": "pickedFile",
      "Sender": state.widget.sourchat["id"],
      "Receiver": state.widget.chatModel["id"]
    });
  }
    sendVideofromgallery(context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.gallery);

    File? file;
    await pickedFile?.readAsBytes();
    MessageModel messageModel = MessageModel("source", pickedFile, "video",
        DateTime.now().toString().substring(10, 16));

   await Provider.of<SocketModel>(context, listen: false)
        .addMessage(messageModel, state.widget.chatModel["id"]);

    state.socket!.emit("video", {
    //  "imageData": "pickedFile",
      "Sender": state.widget.sourchat["id"],
      "Receiver": state.widget.chatModel["id"]
    });
  }


}
