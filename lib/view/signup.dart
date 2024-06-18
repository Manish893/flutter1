import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retryloginlogout/api/networkStatus.dart';
import 'package:retryloginlogout/core/helper.dart';
import 'package:retryloginlogout/custom_ui/cButton.dart';
import 'package:retryloginlogout/custom_ui/cTextForm.dart';
import 'package:retryloginlogout/provider/signupProvider.dart';
import 'package:retryloginlogout/util/string_const.dart';
import 'package:retryloginlogout/view/login.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Consumer<SignupProvide>(
          builder: (context, signupProvider, list) => Column(
            children: [
              Stack(children: [

                signupUi(signupProvider, context),
                  loader(signupProvider, context)
              ],)
                
            ],
          ),
        ),
      ),
    ));
  }

  signupUi(SignupProvide signupProvide, context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Text(
                signupStr,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 35,
                    fontWeight: FontWeight.w800),
              ),
            ),
            CustomTextFormField(
              prefixIcon: Icon(Icons.person),
              labelText: fullNameStr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationStr;
                }
                return null;
              },
              onChanged: (value) {
                signupProvide.setFullName(value);
              },
            ),
            CustomTextFormField(
              prefixIcon: Icon(Icons.email),
              labelText: emailStr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationStr;
                } else if (!signupProvide.emailRegExp.hasMatch(value.trim())) {
                  return emailValidationStr;
                }
                return null;
              },
              onChanged: (value) {
                signupProvide.setEmail(value);
              },
            ),
            CustomTextFormField(
              prefixIcon: Icon(Icons.location_on),
              labelText: addressStr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationStr;
                }
                return null;
              },
              onChanged: (value) {
                signupProvide.setAddress(value);
              },
            ),
            CustomTextFormField(
              prefixIcon: Icon(Icons.person),
              labelText: phoneStr,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationStr;
                } else if (value.length < 10) {
                  return phoneValidationStr;
                }
                return null;
              },
              onChanged: (value) {
                signupProvide.setPhone(int.parse(value));
              },
            ),
            CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationStr;
                } else if (!signupProvide.passwordRegExp.hasMatch(value)) {
                  return passwordValidationStr;
                }
                return null;
              },
              onChanged: (value) {
                signupProvide.setPassword(value);
              },
              obscureText: signupProvide.visibility ? false : true,
              prefixIcon: Icon(Icons.lock),
              labelText: passwordStr,
              suffixIcon: signupProvide.visibility
                  ? IconButton(
                      onPressed: () {
                        signupProvide.setVisibilityForPassword(false);
                      },
                      icon: Icon(Icons.visibility))
                  : IconButton(
                      onPressed: () {
                        signupProvide.setVisibilityForPassword(true);
                      },
                      icon: Icon(Icons.visibility_off)),
            ),
            CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationStr;
                } else if (!signupProvide.passwordRegExp.hasMatch(value)) {
                  return passwordValidationStr;
                } else if (signupProvide.password != value) {
                  return "Password must be same";
                }
                return null;
              },
              onChanged: (value) {
                signupProvide.setConfirmPassword(value);
              },
              obscureText:
                  signupProvide.visibilityForConfirmPassword ? false : true,
              prefixIcon: Icon(Icons.lock),
              labelText: confirmStr,
              suffixIcon: signupProvide.visibilityForConfirmPassword
                  ? IconButton(
                      onPressed: () {
                        signupProvide.setVisibilityForConfirm(false);
                      },
                      icon: Icon(Icons.visibility))
                  : IconButton(
                      onPressed: () {
                        signupProvide.setVisibilityForConfirm(true);
                      },
                      icon: Icon(Icons.visibility_off)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 70,
              child: CustomElevatedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await signupProvide.saveSignupData();
                    if (signupProvide.getSetNetworkstatus ==
                        NetworkStatus.success) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                      Helper.displaySnakBar(
                          context, "Account Created successfully");
                    } else if (signupProvide.getSetNetworkstatus ==
                        NetworkStatus.error) {
                      Helper.displaySnakBar(
                          context, signupProvide.errorMessage!);
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

  loader(SignupProvide signupProvider, context) {
    if (signupProvider.getSetNetworkstatus == NetworkStatus.loading) {
      return Helper.backDropFilter(context);
    } else {
      return SizedBox();
    }
  }
}
