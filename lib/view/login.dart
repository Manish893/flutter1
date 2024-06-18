import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retryloginlogout/api/networkStatus.dart';
import 'package:retryloginlogout/core/helper.dart';
import 'package:retryloginlogout/custom_ui/cButton.dart';
import 'package:retryloginlogout/custom_ui/cTextForm.dart';
import 'package:retryloginlogout/provider/loginProvider.dart';
import 'package:retryloginlogout/util/string_const.dart';
import 'package:retryloginlogout/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var provider = Provider.of<LoginProvider>(context, listen: false);
      provider.readRememberMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, list) => SafeArea(
          child: Stack(
            children: [
              loginUi(loginProvider, context),
              loader(context, loginProvider)
            ],
          ),
        ),
      ),
    );
  }

  loginUi(LoginProvider loginProvider, context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              loginStr,
              style: TextStyle(
                  color: Colors.red, fontSize: 35, fontWeight: FontWeight.w800),
            ),
            CustomTextFormField(
              initialValue:
                  loginProvider.isCheckRememberMe ? loginProvider.email : "",
              prefixIcon: Icon(Icons.email),
              labelText: emailStr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationStr;
                } else if (!loginProvider.emailRegExp.hasMatch(value.trim())) {
                  return emailValidationStr;
                }
                return null;
              },
              onChanged: (value) {
                loginProvider.setEmail(value);
              },
            ),
            CustomTextFormField(
              initialValue:
                  loginProvider.isCheckRememberMe ? loginProvider.password : "",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationStr;
                } else if (!loginProvider.passwordRegExp.hasMatch(value)) {
                  return passwordValidationStr;
                }
                return null;
              },
              onChanged: (value) {
                loginProvider.setPassword(value);
              },
              obscureText: loginProvider.visibility ? false : true,
              prefixIcon: Icon(Icons.lock),
              labelText: passwordStr,
              suffixIcon: loginProvider.visibility
                  ? IconButton(
                      onPressed: () {
                        loginProvider.setVisibilityForPassword(false);
                      },
                      icon: Icon(Icons.visibility))
                  : IconButton(
                      onPressed: () {
                        loginProvider.setVisibilityForPassword(true);
                      },
                      icon: Icon(Icons.visibility_off)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Checkbox(
                    value: loginProvider.isCheckRememberMe,
                    onChanged: (value) {
                      loginProvider.setSaveCheckRememberMe(value);
                      loginProvider.rememberMe(value!);
                    },
                    checkColor: Colors.white,
                  ),
                  Text("Remember me")
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 70,
              child: CustomElevatedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await loginProvider.loginUser();
                    if (loginProvider.getsetNetworkstatus ==
                        NetworkStatus.success) {
                      Helper.displaySnakBar(context, "login Successfully");
                      loginProvider.sharedPreferance();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false);
                    } else if (loginProvider.getsetNetworkstatus ==
                        NetworkStatus.error) {
                      Helper.displaySnakBar(
                          context, "Incorrect email or password");
                    }
                  }
                },
                child: Text(
                  buttonStr,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ));
  }

  loader(context, LoginProvider loginProvider) {
    if (loginProvider.getsetNetworkstatus == NetworkStatus.loading) {
      return Helper.backDropFilter(context);
    } else {
      return SizedBox();
    }
  }
}
