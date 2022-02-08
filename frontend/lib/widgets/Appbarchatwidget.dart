import 'package:flutter/material.dart';

import 'package:provider/src/provider.dart';


class AppBarChatWidget extends StatelessWidget with PreferredSizeWidget {
  final String username;

  const AppBarChatWidget(this.username);
  // const AppBar_ShowMenu({imageName : this.imageName});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      backgroundColor: Color(0xff700bbd),
        leadingWidth: 70,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: const [
              Icon(Icons.arrow_back),
              // CircleAvatar(
              //   radius: 20,
              //   backgroundColor: Colors.grey,
              //   child: Icon(Icons.person,color: Colors.white,),
              // )
            ],
          ),
        ),
        title: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  //widget.chatModel["nickname"],
                  style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
                ),
                  // const Text(
                  //   "last seen today at 12:55",
                  //   style: TextStyle(fontSize: 13),
                  // )
              ],
            ),
          ),
        ),
      );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
