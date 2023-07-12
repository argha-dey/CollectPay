

import 'package:collectpay/Model/LoginResponse/LoginResponseData.dart';

class CommonResponseLogin {
  String token_type;
  String access_token;
  String message;
  LoginResponseData loginResponseData;


  CommonResponseLogin.fromJsonMap(Map<String, dynamic> map):
        token_type = map["success"],
        access_token = map["access_token"],
        message = map["message"],
        loginResponseData = LoginResponseData.fromJsonMap(map["data"]);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_type'] = token_type;
    data['access_token'] = access_token;
    data['message'] = message;
    data['data'] = loginResponseData == null ? null : loginResponseData.toJson();

    return data;
  }

}