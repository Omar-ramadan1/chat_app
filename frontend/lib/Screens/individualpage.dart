import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:delivery_app/Logic/IndividualScreenLogic.dart';
import 'package:delivery_app/contant/constant.dart';

import 'package:delivery_app/model/SocketModel.dart';
import 'package:delivery_app/model/chatmodel.dart';
import 'package:delivery_app/model/messagemodel.dart';
import 'package:delivery_app/widgets/Appbarchatwidget.dart';
import 'package:delivery_app/widgets/OwnMessgaewidget.dart';
import 'package:delivery_app/widgets/Replymessagewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/src/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
//import 'package:emoji_picker/emoji_picker.dart';

class IndividualPage extends StatefulWidget {
  final Map chatModel;
  final Map sourchat;
    final bool counter;
    

//  final List<MessageModel> messages;
  IndividualPage(
    this.chatModel,
    this.sourchat,
    this.counter
    //  this.messages,
  );

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  IO.Socket? socket;
  bool sendButton = false;
  bool show = false;

  FocusNode focusMode = FocusNode();
  ScrollController scrollController = ScrollController();
  IndividualScreenLogic? individualScreenLogic;
  List<MessageModel> messages = [];
 




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socket = context.read<SocketModel>().socket!;

    individualScreenLogic = IndividualScreenLogic(this);

    focusMode.addListener(() {
      if (focusMode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //  print(widget.chatModel["id"]);
    //   print(context.watch<SocketModel>().messages[widget.sourchat["id"]]);
    print("msg::::${messages}");

    messages =
        context.watch<SocketModel>().messages[widget.chatModel["id"]] == null
            ? []
            : context.watch<SocketModel>().messages[widget.chatModel["id"]];
    print("msg::::is${messages}");
  }

  void sendMessage(String message, String sourceId, String targetId) {
    setMessage("source", message);

    socket!.emit("message",
        {"message": message, "Sender": sourceId, "Receiver": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type, message, "text", DateTime.now().toString().substring(10, 16));

    context
        .read<SocketModel>()
        .addMessage(messageModel, widget.chatModel["id"]);
  }

  TextEditingController messagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff700bbd),
      backgroundColor: Colors.grey,
      appBar: AppBarChatWidget(widget.chatModel["name"]),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: messages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return Container(
                        height: 70,
                      );
                    }
                    if (messages[index].type == "source") {
                      return OwnMessageCard(messages[index].message,
                          messages[index].time, messages[index].messageType,widget.counter);
                    } else {
                      return ReplyCard(messages[index].message,
                          messages[index].time, messages[index].messageType);
                    }
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 56,
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height -7,
                          child: Card(
                            margin:
                                EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              focusNode: focusMode,
                              controller: messagecontroller,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              minLines: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  setState(() {
                                    sendButton = true;
                                  });
                                } else {
                                  setState(() {
                                    sendButton = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "       type a message",
                           
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                     
                                           
                                              individualScreenLogic
                                                                    ?.sendImagefromgalley(
                                                                        context);
                                      },
                                      icon: Icon(Icons.camera_alt,
                                          color: Colors.black),
                                    ),
                                    sendButton
                                        ? IconButton(
                                            onPressed: () {
                                              if (sendButton) {
                                                print("llll");

                                                scrollController.animateTo(
                                                    scrollController.position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeOut);
                                                sendMessage(
                                                    messagecontroller.text,
                                                    widget.sourchat["id"],
                                                    widget.chatModel["id"]);

                                                messagecontroller.clear();
                                                setState(() {
                                                  sendButton = false;
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              Icons.send,
                                              color: Colors.black,
                                            ))
                                        : IconButton(
                                            onPressed: () async {
                                     
                                            },
                                            icon: Icon(Icons.send))
                                  ],
                                ),
                                contentPadding: EdgeInsets.all(5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          //     show ? emojeSelect() : Container()
          ],
        ),
      ),
    );
  }

  // Widget emojeSelect() {
  //   return EmojiPicker(
  //       rows: 4,
  //       columns: 7,
  //       onEmojiSelected: (emoji, category) {
  //         print(emoji);
  //         setState(() {
  //           // messagecontroller.text == null ?messagecontroller.text = emoji.emoji :  messagecontroller.text = messagecontroller.text + emoji.emoji;
  //           messagecontroller.text = emoji.emoji + messagecontroller.text;
  //         });
  //       });
  // }
}
