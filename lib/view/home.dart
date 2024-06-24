import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retryloginlogout/api/networkStatus.dart';
import 'package:retryloginlogout/core/helper.dart';
import 'package:retryloginlogout/custom_ui/cButton.dart';
import 'package:retryloginlogout/provider/loginProvider.dart';
import 'package:retryloginlogout/view/kfc.dart';
import 'package:retryloginlogout/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    getValueFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<LoginProvider>(
        builder: (context, loginProvider, list) => Column(
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
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.5,
              child: CustomElevatedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text("Kfc"),
                primary: Colors.green,
                onPrimary: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Kfc()),
                  );
                },
              ),
            ),
            // loginProvider.getsetNetworkstatus == NetworkStatus.loading
            //     ? CircularProgressIndicator()
            //     : Column(
            //         children: loginProvider.userList
            //             .map((e) => Column(
            //                   children: [Text("Name : ${e.fullName!}")],
            //                 ))
            //             .toList(),
            //       ),
            Expanded(
              child: ListView.builder(
                itemCount: loginProvider.userList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(loginProvider.userList[index].id!),
                        Text(loginProvider.userList[index].fullName!),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Do you really want to delete"),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await loginProvider
                                            .deleteIdFromDataBase(loginProvider
                                                .userList[index].id!);

                                        if (loginProvider.getDeleteStatus ==
                                            NetworkStatus.success) {
                                          // Helper.displaySnakBar(
                                          //     context, "Delete successfully");
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home()),
                                              (route) => false);
                                        } else if (loginProvider
                                                .getDeleteStatus ==
                                            NetworkStatus.error) {
                                          Helper.displaySnakBar(
                                              context, "Failed to delete");
                                        }
                                      },
                                      child: Text("Yes"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Handle No action
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text("No"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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

  getValueFromFirebase() {
    Future.delayed(Duration.zero, () {
      var provider = Provider.of<LoginProvider>(context, listen: false);
      provider.getValueFromDataBase();
    });
  }
}
