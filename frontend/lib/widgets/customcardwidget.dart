import 'package:delivery_app/Screens/individualpage.dart';
import 'package:delivery_app/model/SocketModel.dart';
import 'package:delivery_app/model/chatmodel.dart';
import 'package:delivery_app/model/messagemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CustomCard extends StatelessWidget {
  final Map chatModel;
  final Map sourcechat;
  final bool counter;
  // final List<MessageModel> messages;
  CustomCard(this.chatModel, this.sourcechat, this.counter
      //this.messages,

      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        IndividualPage(chatModel, sourcechat, counter)));
            context.read<SocketModel>().resetCounter(chatModel["id"]);
          },
          child: Container(
            color: counter == false ? Colors.transparent : Colors.white,
            height: 100,
            child: ListTile(
              leading: Container(
                height: 50,
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.person,
                      size: 50,
                    )),
              ),
              title: Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Text(
                    chatModel["name"],
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 20, left: 80),
          child: Divider(),
        ),
      ],
    );
  }
}
