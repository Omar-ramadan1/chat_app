import 'package:delivery_app/Screens/signupscreen.dart';
import 'package:delivery_app/model/SocketModel.dart';
import 'package:delivery_app/model/UserData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/homescreen.dart';
import 'Screens/loginScreen.dart';
import 'Screens/splashscreen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      //  ChangeNotifierProvider(create: (_) => Camera()),
      ChangeNotifierProvider(create: (_) => UserData()),
      ChangeNotifierProvider(create: (_) => SocketModel()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//context.read<Camera>().process();
    context.read<UserData>().getUserData();
    //print(context.read<UserData>().userData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF075E54),
        accentColor: Color(0xFF128C7E),
      ),
      home:
     context.read<UserData>().getUserData == null
       ?
           SignUpScreen()
       : SplashScreen(),
     // context.read<UserData>().userData == null ?
      //    MainLoginScreen()
      //  :
      //    HomeScreen(),
    );
  }
}
