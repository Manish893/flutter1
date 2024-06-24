import 'package:retryloginlogout/api/apiResponse.dart';
import 'package:retryloginlogout/model/signupModel.dart';

abstract class ApiService {
  Future<ApiResponse> signup(SignupModel signupModel);
  Future<ApiResponse> login(SignupModel signupModel);
  Future<ApiResponse> getValue();
  Future<ApiResponse> deleteID(String id);
}
