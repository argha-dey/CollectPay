import 'package:collectpay/Model/LoginResponse/LoginResponseData.dart';


class CommonResponseAddToCart {
  bool success;
  String message;
  LoginResponseData loginResponseData;

  CommonResponseAddToCart.fromJsonMap(Map<String, dynamic> map):
        success = map["success"],
        message = map["message"];
}