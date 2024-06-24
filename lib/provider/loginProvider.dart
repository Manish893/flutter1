import 'package:flutter/foundation.dart';
import 'package:retryloginlogout/api/apiResponse.dart';
import 'package:retryloginlogout/api/apiService.dart';
import 'package:retryloginlogout/api/apiServiceImpl.dart';
import 'package:retryloginlogout/api/networkStatus.dart';
import 'package:retryloginlogout/model/signupModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String? email;
  String? password;
  RegExp emailRegExp = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
  RegExp passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  bool visibility = false;
  ApiService apiService = ApiServiceImpl();
  NetworkStatus _setNetworkstatus = NetworkStatus.idel;
  NetworkStatus get getsetNetworkstatus => _setNetworkstatus;
  String? errorMessage;
  bool isCheckRememberMe = false;
  List<SignupModel> userList = [];
  NetworkStatus _setDeleteStatus = NetworkStatus.idel;
  NetworkStatus get getDeleteStatus => _setDeleteStatus;
  setDeleteStatus(NetworkStatus status) {
    _setDeleteStatus = status;
    notifyListeners();
  }

  setSaveCheckRememberMe(value) {
    isCheckRememberMe = value;
    notifyListeners();
  }

  setLoading(NetworkStatus status) {
    _setNetworkstatus = status;
    notifyListeners();
  }

  setVisibilityForPassword(bool value) {
    visibility = value;
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

  loginUser() async {
    SignupModel signupModel = SignupModel(email: email, password: password);
    ApiResponse response = await apiService.login(signupModel);
    if (response.networkStatus == NetworkStatus.success) {
      setLoading(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      setLoading(NetworkStatus.error);
      errorMessage = response.errorMessage;
    }
  }

  sharedPreferance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
  }

  rememberMe(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      await prefs.setBool('rememberMe', true);
      await prefs.setString('email', email!);
      await prefs.setString('password', password!);
    } else {
      await prefs.remove('rememberMe');
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  readRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? "";
    password = prefs.getString('password') ?? "";
    notifyListeners();
  }

  getValueFromDataBase() async {
    if (_setNetworkstatus != NetworkStatus.loading) {
      setLoading(NetworkStatus.loading);
    }
    ApiResponse response = await apiService.getValue();
    if (response.networkStatus == NetworkStatus.success) {
      userList = response.data;
      setLoading(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      errorMessage = response.errorMessage;
      setLoading(NetworkStatus.error);
    }
  }

  deleteIdFromDataBase(String id) async {
    if (_setDeleteStatus != NetworkStatus.loading) {
      setDeleteStatus(NetworkStatus.loading);
    }
    ApiResponse response = await apiService.deleteID(id);
    if (response.networkStatus == NetworkStatus.success) {
      setDeleteStatus(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      errorMessage = response.errorMessage;
      setDeleteStatus(
        NetworkStatus.error,
      );
    }
  }
}
