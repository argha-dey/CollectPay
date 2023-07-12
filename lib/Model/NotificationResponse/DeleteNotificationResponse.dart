

class DeleteNotificationResponse {
  bool success;
  String message;


  DeleteNotificationResponse({
    this.success,
    this.message,


  });


  factory DeleteNotificationResponse.fromJson(Map<String, dynamic> parsedJson){
    return DeleteNotificationResponse(
      success: parsedJson['success'],
      message: parsedJson['message'],

    );
  }


}