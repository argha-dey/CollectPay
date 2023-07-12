
import 'package:collectpay/Model/Otp/OtpResponseData.dart';

class CommonResponseOtp {

  OtpResponseData otpResponseData;

  CommonResponseOtp.fromJsonMap(Map<String, dynamic> map):

        otpResponseData = OtpResponseData.fromJsonMap(map["data"]);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['data'] = otpResponseData == null ? null : otpResponseData.toJson();

    return data;
  }

}