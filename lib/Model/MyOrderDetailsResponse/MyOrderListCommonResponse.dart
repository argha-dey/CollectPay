
class MyOrderListCommonResponse {
  bool success;
  String message;
  List<dynamic> pastorderdata;

  MyOrderListCommonResponse({
    this.success,
    this.message,
    this.pastorderdata,

  });

  factory MyOrderListCommonResponse.fromJson(Map<String, dynamic> parsedJson){

    return MyOrderListCommonResponse(
      success: parsedJson['success'],
      message: parsedJson['message'],
      pastorderdata: parsedJson['pastorderdata'],

    );
  }

}