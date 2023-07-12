
class CommonContactUsResponse {
  bool success;
  String message;
  List<dynamic> contactusdata;


  CommonContactUsResponse({
    this.success,
    this.message,
    this.contactusdata,

  });

  factory CommonContactUsResponse.fromJson(Map<String, dynamic> parsedJson){

    return CommonContactUsResponse(
        success: parsedJson['success'],
        message: parsedJson['message'],
      contactusdata: parsedJson['contactusdata'],

    );
  }

}