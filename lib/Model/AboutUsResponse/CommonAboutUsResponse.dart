
class CommonAboutUsResponse {
  bool success;
  String message;
  List<dynamic> aboutusdata;


  CommonAboutUsResponse({
    this.success,
    this.message,
    this.aboutusdata,

  });

  factory CommonAboutUsResponse.fromJson(Map<String, dynamic> parsedJson){

    return CommonAboutUsResponse(
        success: parsedJson['success'],
        message: parsedJson['message'],
      aboutusdata: parsedJson['aboutusdata'],

    );
  }

}