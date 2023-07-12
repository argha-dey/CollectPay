

  class CommonUserProfileResponse {
  bool success;
  String message;
  List<dynamic> userdata;

  CommonUserProfileResponse({
  this.success,
  this.message,
  this.userdata,

  });

  factory CommonUserProfileResponse.fromJson(Map<String, dynamic> parsedJson){

  return CommonUserProfileResponse(
  success: parsedJson['success'],
  message: parsedJson['message'],
  userdata: parsedJson['userdata'],

  );
  }


}