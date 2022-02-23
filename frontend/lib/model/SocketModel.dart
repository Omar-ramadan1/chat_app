import 'dart:typed_data';

import 'package:delivery_app/contant/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:audioplayers/audioplayers.dart';

import 'messagemodel.dart';

const kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';

class SocketModel with ChangeNotifier {
  Map _itemcounters = {};
  Map get itemCounts => _itemcounters;
  set itemCounts(Map item) {
    _itemcounters = item;
    notifyListeners();
  }
  Map _isChatOpen = {};
  Map get isChatOpen => _isChatOpen;
  set isChatOpen(Map item) {
    isChatOpen = item;
    notifyListeners();
  }

  IO.Socket? _socket;
  IO.Socket? get socket => _socket;
  Map<String, List<MessageModel>> _messages = {};
  Map get messages => _messages;

  void connect() {
    _socket = IO.io("${serverlUrl}", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    _socket!.connect();
    _socket!.onConnect((data) {
      print("Connected");
      socket!.on("message", (msg) {
        final player = AudioCache();
        player.play("tone.mp3");
        MessageModel messageModel = MessageModel("Receiver", msg["message"],
            "text", DateTime.now().toString().substring(10, 16));
        addMessage(messageModel, msg["Sender"], isSender: true);
        notifyListeners();
      });
      socket!.on("image", (msg) {
             final player = AudioCache();
        player.play("tone.mp3");
        List<int> intList = msg["imageData"]
            .cast<int>()
            .toList(); //This is the To convert from List to List<int>
        Uint8List data = Uint8List.fromList(
            intList); //This is the To convert from List<int> to Uni8List
        MessageModel messageModel = MessageModel("Receiver", data, "image",
            DateTime.now().toString().substring(10, 16));
        addMessage(messageModel, msg["Sender"], isSender: true);

        notifyListeners();
      });
            socket!.on("video", (msg) {
        List<int> intList = msg["videoData"]
            .cast<int>()
            .toList(); //This is the To convert from List to List<int>
        Uint8List data = Uint8List.fromList(
            intList); //This is the To convert from List<int> to Uni8List
        MessageModel messageModel = MessageModel("Receiver", data, "video",
            DateTime.now().toString().substring(10, 16));
        addMessage(messageModel, msg["Sender"], isSender: true);

        notifyListeners();
      });
      socket!.on("sharedmsg", (msg) {
        List<int> intList = msg["imageData"]
            .cast<int>()
            .toList(); //This is the To convert from List to List<int>
        Uint8List data = Uint8List.fromList(
            intList); //This is the To convert from List<int> to Uni8List
        MessageModel messageModel = MessageModel("Receiver", data, "message",
            DateTime.now().toString().substring(10, 16));
        addMessage(messageModel, msg["Sender"], isSender: true);

        notifyListeners();
      });
    });
  }
  

  addMessage(MessageModel messageModelParameter,  receiverId, {bool? isSender}) async{
    print(isChatOpen);
    if (messages[receiverId.toString()] == null) {
      messages[receiverId.toString()] = <MessageModel>[messageModelParameter];
        if (isSender == true)
          itemCounts[receiverId.toString()] = true;
    } else  {
      messages[receiverId.toString()].add(messageModelParameter);
        if (isSender == true)
          itemCounts[receiverId.toString()] = true;
    }
    notifyListeners();
  }

  resetCounter(String id) {
    itemCounts[id] =false;
        notifyListeners();

  }

  setChatOpen(String id , bool isOpen) {
    _isChatOpen[id] = isOpen;
    print(isChatOpen);
    notifyListeners();

  }
}
