import 'package:retryloginlogout/api/networkStatus.dart';

class ApiResponse {
  dynamic data;
  String? errorMessage;
  NetworkStatus? networkStatus;
  ApiResponse({this.data, this.errorMessage, this.networkStatus});
}
