import 'package:delivery_app/Screens/loginScreen.dart';
import 'package:delivery_app/Screens/signupscreen.dart';
import 'package:delivery_app/model/UserData.dart';
import 'package:delivery_app/widgets/splashscreen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2500), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            context.read<UserData>().userData == null ? 
       SignUpScreen()
     :
       HomeScreen(),
     //    MainLoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SplashScreenWidget()
    );
  }
}
