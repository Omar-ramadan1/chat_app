import 'dart:convert';

import 'package:delivery_app/contant/constant.dart';
import 'package:delivery_app/model/SocketModel.dart';
import 'package:delivery_app/model/UserData.dart';
import 'package:delivery_app/model/chatmodel.dart';
import 'package:delivery_app/model/messagemodel.dart';
import 'package:delivery_app/widgets/customcardwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List UsersList = [];
  List FindUser = [];
  Map itemCounts = {};

  bool _isSearching = false;

  final _searchTextController = TextEditingController();
  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      decoration: InputDecoration(
        hintText: 'Search user by name...',
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 18),
      ),
      style: TextStyle(fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedCharacter) {
    // for (var i = 0; i < UsersList.length; i++)
    FindUser = UsersList.where(
            (user) => user["name"].toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearsearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: Colors.red,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearching,
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ))
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearsearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearsearch() {
    _searchTextController.clear();
  }

  Widget _buildAppBarTitle() {
    return Text(
      "chat me",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  getUsers() async {
    var url = Uri.parse('${serverURL1}auth/signup');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      setState(() {
        UsersList = jsonObj['result'];
        FindUser = UsersList;
        //    print(UsersList);

        List filter = [];
        UsersList.forEach((element) {
          if (element["id"] == context.read<UserData>().userData!["id"]) {
          } else {
            filter.add(element);
          }
        });
        UsersList = filter;
        for (var i = 0; i < UsersList.length; i++)
          print("printlist:${UsersList}");
      });
    }
  }

  IO.Socket? socket;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    getUsers();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
//    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    context.read<SocketModel>().connect();
    if (context.read<UserData>().userData != null) {
      print("signedIN");
      context
          .read<SocketModel>()
          .socket!
          .emit("signin", context.read<UserData>().userData!["id"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff700bbd),
          // title: Text("Chat me"),
          leading: _isSearching
              ? BackButton(
                  color: Colors.grey,
                )
              : Container(),
          title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
          actions: _buildAppActions(),
        ),
        body:
            //ChatPage(),
            Scaffold(
                backgroundColor: Color(0xffa9b0ba),
                body: ListView(
                  children: [
                    for (var i = 0;
                        i <
                            (_searchTextController.text.isEmpty
                                ? UsersList.length
                                : FindUser.length);
                        i++)
                      CustomCard(
                          UsersList[i],
                          context.watch<UserData>().userData!,
                          context
                                      .watch<SocketModel>()
                                      .itemCounts[UsersList[i]["id"]] ==
                                  null
                              ? itemCounts[UsersList[i]["id"]] = false
                              : context
                                  .watch<SocketModel>()
                                  .itemCounts[UsersList[i]["id"]])
                  ],
                )));
  }
}
