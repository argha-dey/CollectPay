

import 'package:collectpay/Model/RegistrationResponse/RegistrationResponseData.dart';

class CommonResponseRegister {
  String access_token = "";
  String token_type= "";
  String message= "";
  RegistrationResponseData registrationResponseData;

  CommonResponseRegister.fromJsonMap(Map<String, dynamic> map):
        access_token = map["access_token"],
        token_type = map["token_type"],
        message = map["message"],
        registrationResponseData = RegistrationResponseData.fromJsonMap(map["data"]);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = access_token;
    data['token_type'] = token_type;
    data['message'] = message;
    data['data'] = registrationResponseData == null ? null : registrationResponseData.toJson();

    return data;
  }

}