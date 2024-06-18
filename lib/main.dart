import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retryloginlogout/core/helper.dart';
import 'package:retryloginlogout/firebase_options.dart';
import 'package:retryloginlogout/provider/loginProvider.dart';
import 'package:retryloginlogout/provider/signupProvider.dart';
import 'package:retryloginlogout/view/home.dart';
import 'package:retryloginlogout/view/login.dart';
import 'package:retryloginlogout/view/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLogin = false;
  @override
  void initState() {
    getValueFromSharedPreference();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignupProvide>(create: (_) => SignupProvide()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isUserLogin ? Home() : Login(),
      ),
    );
  }

  getValueFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isUserLogin = prefs.getBool('isLogin') ?? false;
    setState(() {
      isUserLogin;
    });
  }
}
