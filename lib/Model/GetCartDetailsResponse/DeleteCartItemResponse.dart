

class DeleteCartItemResponse {
  bool success;
  String message;


  DeleteCartItemResponse({
    this.success,
    this.message,


  });


  factory DeleteCartItemResponse.fromJson(Map<String, dynamic> parsedJson){
    return DeleteCartItemResponse(
      success: parsedJson['success'],
      message: parsedJson['message'],

    );
  }


}