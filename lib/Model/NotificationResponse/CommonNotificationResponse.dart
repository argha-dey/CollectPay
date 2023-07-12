

class CommonNotificationResponse {
  bool success;
  String message;
  List<dynamic> notificationdata;

  CommonNotificationResponse({
    this.success,
    this.message,
    this.notificationdata,

  });


  factory CommonNotificationResponse.fromJson(Map<String, dynamic> parsedJson){
    return CommonNotificationResponse(
      success: parsedJson['success'],
      message: parsedJson['message'],
      notificationdata: parsedJson['notificationdata'],
    );
  }


}