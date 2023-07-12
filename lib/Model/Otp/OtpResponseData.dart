class OtpResponseData{
  bool status;
  String token;
  String message;




  OtpResponseData.fromJsonMap(Map<String, dynamic> map):
        status = map["status"],
        token = map["token"],
        message = map["message"];



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['token'] = token;
    data['message'] = message;

    return data;
  }

}