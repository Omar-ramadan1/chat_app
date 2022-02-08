import 'dart:convert';

import 'package:delivery_app/Screens/loginScreen.dart';
import 'package:delivery_app/contant/constant.dart';
import 'package:delivery_app/model/UserData.dart';
import 'package:delivery_app/widgets/buttonwidget.dart';
import 'package:delivery_app/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';

import 'homescreen.dart';

class SignUpScreen extends StatefulWidget {
  static const routename = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passController = TextEditingController();

    late Map? sharedPrefrenceCheck;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefrenceCheck = context.read<UserData>().userData;

    // context.read<UserData>().getUserData();
    // print(context.read<UserData>().userData);
    //print(sharedPrefrenceCheck);
  }
  postUser() async {
    print(emailController.text);
    var response =
        await http.post(Uri.parse('${serverURL1}auth/signup'), body: {
      "email": emailController.text,
      "name": nameController.text,
      "password": passController.text,
      "type": "0"
    });

    print(response.body);
        print(response.body);
    Map jsonBody = jsonDecode(response.body);
    Map userData = {
      "id": jsonBody["id"],
      "email":jsonBody["email"],
      "name": jsonBody["name"],
      "password": jsonBody["password"],
      "type": jsonBody["type"]
 
    };
    context.read<UserData>().setUserDataFunc(userData);
    return response;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff700bbd),
      body: ListView(
        children: [
          Form(
            key: _key,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 150,
                    child: Image.asset("assets/images/chatt.png"),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextFormFieldWidget(
                          emailController,
                          "email",
                          Icon(
                            Icons.person,
                            color: Color(0xff700bbd),
                          ), (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                         if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      }, false)),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextFormFieldWidget(nameController, "Your name",
                          Icon(Icons.dehaze, color: Color(0xff700bbd)),
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }

                        return null;
                      }, false)),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextFormFieldWidget(
                          passController,
                          "Your password",
                          Icon(Icons.dehaze, color: Color(0xff700bbd)),
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }

                        return null;
                      }, true)),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: ButtonWidget('SignUp', () async {
                        if (_key.currentState!.validate()) {
                             http.Response response = await
                          postUser();
                          Map responseMap = jsonDecode(response.body);
                          context
                              .read<UserData>()
                              .setUserDataFunc(responseMap);
                          nameController.clear();
                          emailController.clear();
                          passController.clear();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => LoginScreen()
                                  )
                                  
                                  );
                        }
                      })),

                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("already have account ",style: TextStyle(fontSize: 15,color: Colors.white),),
                    InkWell(
                      onTap: (){
                             Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => LoginScreen()
                                  )
                                  
                                  );
                      },
                      child: Text("sign in",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),

                          ],
                        ),
                      )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
