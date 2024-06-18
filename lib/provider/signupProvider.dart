import 'package:flutter/material.dart';
import 'package:retryloginlogout/api/apiResponse.dart';
import 'package:retryloginlogout/api/apiService.dart';
import 'package:retryloginlogout/api/apiServiceImpl.dart';
import 'package:retryloginlogout/api/networkStatus.dart';
import 'package:retryloginlogout/model/signupModel.dart';

class SignupProvide extends ChangeNotifier {
  bool visibility = false;
  bool visibilityForConfirmPassword = false;
  RegExp emailRegExp = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
  RegExp passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  String? full_Name, address, email, password, confirmPassword;
  int? phone;
  ApiService apiService = ApiServiceImpl();
  NetworkStatus _setNetworkStatus = NetworkStatus.idel;
  NetworkStatus get getSetNetworkstatus => _setNetworkStatus;
  String? errorMessage;

  setLoading(NetworkStatus status) {
    _setNetworkStatus = status;
  }

  setVisibilityForPassword(bool value) {
    visibility = value;
    notifyListeners();
  }

  setFullName(String value) {
    full_Name = value;
    notifyListeners();
  }

  setAddress(String value) {
    address = value;
    notifyListeners();
  }

  setEmail(String value) {
    email = value;
    notifyListeners();
  }

  setPassword(String value) {
    password = value;
    notifyListeners();
  }

  setConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  setPhone(int value) {
    phone = value;
  }

  setVisibilityForConfirm(value) {
    visibilityForConfirmPassword = value;
    notifyListeners();
  }

  saveSignupData() async {
    SignupModel signupModel = SignupModel(
        fullName: full_Name,
        email: email,
        address: address,
        phone: phone,
        password: password);
    ApiResponse response = await apiService.signup(signupModel);
    if (response.networkStatus == NetworkStatus.success) {
      setLoading(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      setLoading(NetworkStatus.error);
      errorMessage = response.errorMessage;
    }
  }
}
