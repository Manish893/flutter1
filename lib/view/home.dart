import 'package:flutter/material.dart';
import 'package:retryloginlogout/core/helper.dart';
import 'package:retryloginlogout/custom_ui/cButton.dart';
import 'package:retryloginlogout/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text("Home Page"),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70,
            child: CustomElevatedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onPressed: () async {
                await logoutFromSharedPreference();
              
              },
              child: Text(
                "logout",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
          ),
        ],
      )),
    );
  }

  logoutFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogin');
    Helper.displaySnakBar(context, "Logged out successfully");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

}
