import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retryloginlogout/api/apiResponse.dart';
import 'package:retryloginlogout/api/apiService.dart';
import 'package:retryloginlogout/api/networkStatus.dart';
import 'package:retryloginlogout/model/signupModel.dart';

class ApiServiceImpl extends ApiService {
  bool isUserExist = false;
  List<SignupModel> model = [];
  @override
  Future<ApiResponse> signup(SignupModel signupModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("signup")
          .add(signupModel.toJson());
      return ApiResponse(networkStatus: NetworkStatus.success);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMessage: e.toString());
    }
  }

  @override
  Future<ApiResponse> login(SignupModel signupModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("signup")
          .where("email", isEqualTo: signupModel.email)
          .where("password", isEqualTo: signupModel.password)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          isUserExist = true;
        } else {
          isUserExist = false;
        }
      });
    } catch (e) {
      ApiResponse(
          networkStatus: NetworkStatus.error, errorMessage: e.toString());
    }
    return ApiResponse(networkStatus: NetworkStatus.success, data: isUserExist);
  }

  @override
  Future<ApiResponse> getValue() async {
    try {
      await FirebaseFirestore.instance.collection("signup").get().then((value) {
        model.addAll(
            value.docs.map((e) => SignupModel.fromJson(e.data())).toList());
        print(model);
        for (int i = 0; i < model.length; i++) {
          model[i].id = value.docs[i].id;
        }
        print(model);
      });
      return ApiResponse(data: model, networkStatus: NetworkStatus.success);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMessage: e.toString());
    }
  }

  @override
  Future<ApiResponse> deleteID(String id) async {
    try {
      await FirebaseFirestore.instance.collection("signup").doc(id).delete();
      return ApiResponse(networkStatus: NetworkStatus.success);
    } catch (e) {
      return ApiResponse(errorMessage: e.toString(),networkStatus: NetworkStatus.error);
    }
  }
}
